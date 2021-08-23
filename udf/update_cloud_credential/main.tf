terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "~>0.9"
    }
  }
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = format("https://%s.console.ves.volterra.io/api", var.tenant)
}

data "http" "aws_access_key" {
  url = "http://metadata.udf/cloudAccounts"
}

resource "volterra_cloud_credentials" "aws" {
  name        = format("%s-cred", var.prefix)
  description = format("AWS credential will be used to create sites")
  namespace   = "system"
  aws_secret_key {
    access_key = jsondecode(data.http.aws_access_key.body).cloudAccounts[0].apiKey
    secret_key {
      clear_secret_info {
        url = "string:///${base64encode(jsondecode(data.http.aws_access_key.body).cloudAccounts[0].apiSecret)}"
      }
    }
  }
}
