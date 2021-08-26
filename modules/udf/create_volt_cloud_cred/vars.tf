variable "prefix" {
  description = "Prefix for resources created by this module"
  type        = string
  default     = "volt-demo-app"
}

variable "api_p12_file" {
  description = "VoltConsole certificate for authentication"
  type        = string
}

variable "tenant" {
  description = "Volterra tenant name"
  type        = string
}
