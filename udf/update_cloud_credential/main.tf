terraform {
  required_version = ">= 0.12.0"
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


module "udf" {
  source = "github.com/f5devcentral/terraform-udf"
}

resource "volterra_cloud_credentials" "aws" {
  name        = format("%s-cred", var.prefix)
  description = format("AWS credential will be used to create sites")
  namespace   = "system"
  aws_secret_key {
    access_key = module.udf.apiKey
    secret_key {
      clear_secret_info {
        url = "string:///${base64encode(module.udf.apiSecret)}"
      }
    }
  }
}
