# Create Volterra Cloud Credentials
This module will will take the UDF cloud credentials and create an associated Volterra Cloud Credentials. 



## Providers

| Name | Version |
|------|---------|
| <a name="provider_volterra"></a> [volterra](#provider\_volterra) | 0.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_p12_file"></a> [api\_p12\_file](#input\_api\_p12\_file) | VoltConsole certificate for authentication | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for resources created by this module | `string` | `"volt-demo-app"` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Volterra tenant name | `string` | n/a | yes |

## Outputs

No outputs.
