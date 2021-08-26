#!/bin/bash
#Get k3s hostname
k3s_host=$(terraform output -json | jq '.tcp_vs_host_name.value' -r)
scp -i rsa.key ubuntu@"$k3s_host":/etc/rancher/k3s/k3s.yaml .
