output "subnet_id" {
  value = data.aws_subnet.selected.id
}
output "security_group_id" {
  value = data.aws_security_group.selected.id
}

output "demo_app_private_ip" {
  value = aws_instance.k3s.private_ip
}

output "tcp_vs_host_name" {
  value = format("ves-io-%s.ac.vh.ves.io", volterra_tcp_loadbalancer.k3s_ssh.id)
}
