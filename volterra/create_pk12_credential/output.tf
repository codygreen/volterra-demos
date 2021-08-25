output "p12" {
  value = jsondecode(data.local_file.token.content).data
}