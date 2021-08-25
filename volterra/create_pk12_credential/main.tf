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
    filename = "${path.module}/volt.p12.json"
    api_token = "${var.api_token}"
    tenant = "${var.tenant}"
  }

  provisioner "local-exec" {
    command = <<EOF
    curl --location --request POST '${format("https://%s.console.ves.volterra.io/api/web/namespaces/system/api_credentials", self.triggers.tenant)}' \
    --header 'Authorization: APIToken ${self.triggers.api_token}' \
    --header 'Content-Type: application/json' \
    --data-raw '${data.template_file.create_p12_cert.rendered}' \
    >${self.triggers.filename}
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
  filename = null_resource.p12.triggers.filename
}

locals {
  test = "test"
}