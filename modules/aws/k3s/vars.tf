variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "prefix" {
  description = "Prefix for resources created by this module"
  type        = string
  default     = "volt-demo-app"
}

variable "subnet_id" {
  description = "AWS subnet ID for ec2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of AWS Security Group IDs"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
}

variable "site_name" {
  description = "VoltConsole site name"
  type        = string
}

variable "namespace" {
  description = "VoltConsole namespace"
  type        = string
}

variable "tenant" {
  description = "voltConsole tenant name"
  type        = string
}

variable "api_p12_file" {
  description = "VoltConsole certificate for authentication"
  type        = string
}
