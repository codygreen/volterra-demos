# Create Volterra P12 Credential
This module will take a Volterra API Token and generate a Volterra P12 credential for use with vesctl and Terraform.

The module leverages Terraform local_exec so there are some system requirements you should be aware of:
 - linux based host
 - curl
 - jq 
 - base64 



## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | Volterra API Token Credential | `string` | n/a | yes |
| <a name="input_credential_name"></a> [credential\_name](#input\_credential\_name) | Volterra credential name | `string` | `"tf-cred"` | no |
| <a name="input_credential_password"></a> [credential\_password](#input\_credential\_password) | Volterra credential certificate password | `string` | `"tf_cert"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Volterra namespace | `string` | n/a | yes |
| <a name="input_p12_file_path"></a> [p12\_file\_path](#input\_p12\_file\_path) | location to save p12 certificate to | `string` | `""` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Volterra tenant name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_p12"></a> [p12](#output\_p12) | base64 encoded PKCS12 certificate |
