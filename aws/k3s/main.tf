provider "aws" {
  region = var.region
  # access_key = var.AccessKeyID
  # secret_key = var.SecretAccessKey
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:ves.io/subnet-type"
    values = ["workload"]
  }
  filter {
    name   = "tag:ves.io/site_name"
    values = [var.site_name]
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "tag:ves.io/site_name"
    values = [var.site_name]
  }
}

#
# Create a random id
#
resource "random_id" "id" {
  byte_length = 2
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "k3s" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = format("%s-%s-%s", var.prefix, "demo-app", random_id.id.hex)
  public_key = tls_private_key.k3s.public_key_openssh
}

resource "local_file" "key" {
  filename        = "${path.module}/rsa.key"
  content         = tls_private_key.k3s.private_key_pem
  file_permission = "0400"
}

resource "aws_instance" "k3s" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.selected.id
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  key_name               = aws_key_pair.generated_key.key_name
  user_data              = <<-EOF
#!/bin/bash
apt-get update
apt-get upgrade -y
curl -sfL https://get.k3s.io | sh -
EOF

  tags = {
    Name = format("%s-k3s-%s", var.prefix, random_id.id.hex)
  }
}
