#!/bin/bash

echo "Cambiando DNS a 8.8.8.8"

# Deshabilitar systemd-resolved y establecer DNS manualmente
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
sudo rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Actualizar paquetes
echo "Actualizando paquetes..."
sudo apt update && sudo apt upgrade -y

# Agregar la clave GPG y el repositorio de HashiCorp
echo "Agregando clave GPG de HashiCorp..."
wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "Agregando repositorio de HashiCorp..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Instalar Terraform
echo "Instalando Terraform..."
sudo apt update && sudo apt install terraform -y

# Instalar Ansible
echo "Instalando Ansible..."
sudo apt install ansible -y

# Verificar instalación
echo "Verificando instalación de Terraform..."
terraform -v