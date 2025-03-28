#!/bin/bash

# Deshabilitar systemd-resolved
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
sudo rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Actualizar paquetes
sudo apt-get update && sudo apt-get upgrade -y

 export DEBIAN_FRONTEND=noninteractive
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt-get update
  sudo apt-get install -y terraform ansible

# Ejecutar Terraform en la maquina control
terraform init
terraform apply -auto-approve
