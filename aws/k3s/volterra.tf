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

resource "volterra_origin_pool" "k3s_ssh" {
  name      = format("%s-k3s-ssh-%s", var.prefix, random_id.id.hex)
  namespace = var.namespace
  origin_servers {
    private_name {
      dns_name        = aws_instance.k3s.private_dns
      inside_network  = true
      outside_network = false
      site_locator {
        site {
          name      = var.site_name
          namespace = "system"
        }
      }
    }
  }
  no_tls                 = true
  port                   = 22
  same_as_endpoint_port  = true
  loadbalancer_algorithm = "LB_OVERRIDE"
  endpoint_selection     = "LOCAL_PREFERRED"
}

resource "volterra_tcp_loadbalancer" "k3s_ssh" {
  name        = format("%s-k3s-ssh-%s", var.prefix, random_id.id.hex)
  namespace   = var.namespace
  listen_port = 22
  # domains     = ["k3s-ssh.gsa.f5demos.com"]
  origin_pools_weights {
    pool {
      name      = volterra_origin_pool.k3s_ssh.name
      namespace = var.namespace
    }
  }

  advertise_on_public_default_vip = true

  retract_cluster                = true
  hash_policy_choice_round_robin = true
}
