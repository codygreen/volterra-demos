variable "api_token" {
  description = "Volterra API Token Credential"
  type        = string
}

variable "tenant" {
  description = "Volterra tenant name"
  type        = string
}

variable "namespace" {
  description = "Volterra namespace"
  type        = string
}

variable "credential_name" {
  description = "Volterra credential name"
  type        = string
  default     = "tf-cred"
}

variable "credential_password" {
  description = "Volterra credential certificate password"
  type        = string
  default     = "tf_cert"
}

variable "p12_file_path" {
  description = "location to save p12 certificate to"
  type        = string
  default     = ""
}