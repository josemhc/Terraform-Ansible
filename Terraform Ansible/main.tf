terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}


resource "virtualbox_vm" "node" {
  name      = "node"
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "512 mib"

  network_adapter {
    type = "bridged"
    host_interface = "enp37s0"
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "[miservidores]" > inventory.ini
      echo "${self.network_adapter.0.ipv4_address} # cambiar según la ip que te suelte el terraform" >> inventory.ini
      echo "" >> inventory.ini
      echo "[miservidores:vars]" >> inventory.ini
      echo "ansible_user=vagrant" >> inventory.ini
      echo "ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key" >> inventory.ini
      
      ansible-playbook -i inventory.ini playbook.yml --extra-vars "ansible_become_password=1530" -e 'ansible_become_method=sudo' -e 'ansible_become_user=root' --diff -v --ssh-common-args='-o StrictHostKeyChecking=no'
    EOT
  }
}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}