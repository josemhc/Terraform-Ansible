provider "virtualbox" {}

resource "virtualbox_vm" "web-node" {
  name      = "web-node"
  image     = "bento/ubuntu-22.04"
  memory    = 1024
  cpus      = 1

  network_adapter {
    type = "hostonly"
    host_interface = "vboxnet0"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y python3"
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
      host        = "192.168.50.4"
    }
  }
}
