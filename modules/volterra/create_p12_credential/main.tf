terraform {
  required_version = ">= 0.12.0"
}

data "template_file" "create_p12_cert" {
  template = file("${path.module}/create_p12_cert.tpl")
  vars = {
    NAME = "${var.credential_name}"
    PWD  = "${var.credential_password}"
  }
}

resource "null_resource" "p12" {

  triggers = {
    credential_name = "${var.credential_name}"
    output_file     = "${path.module}/${var.credential_name}.json"
    api_token       = "${var.api_token}"
    tenant          = "${var.tenant}"
    p12_file_path   = "${local.p12_file_path}"
  }

  provisioner "local-exec" {
    command = <<EOF
    curl --location --request POST '${format("https://%s.console.ves.volterra.io/api/web/namespaces/system/api_credentials", self.triggers.tenant)}' \
    --header 'Authorization: APIToken ${self.triggers.api_token}' \
    --header 'Content-Type: application/json' \
    --data-raw '${data.template_file.create_p12_cert.rendered}' \
    >${self.triggers.output_file}
    cat ${self.triggers.output_file} | jq '.data' -r | base64 --decode > ${self.triggers.p12_file_path}/${self.triggers.credential_name}.p12
    EOF
    environment = {
      APIToken = var.api_token
    }
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sh delete_credential.sh"
  }
}

data "local_file" "token" {
  filename = null_resource.p12.triggers.output_file
}

locals {
  test = "test"
}

locals {
  p12_file_path = var.p12_file_path != "" ? var.p12_file_path : path.module
}