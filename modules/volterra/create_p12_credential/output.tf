output "p12" {
  description = "base64 encoded PKCS12 certificate"
  value       = jsondecode(data.local_file.token.content).data
}
