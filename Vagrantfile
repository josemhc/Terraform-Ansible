# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    config.vm.define :control do |control|
            control.vm.box = "bento/ubuntu-22.04"
            control.vm.network "private_network", ip: "192.168.50.3"
            control.vm.hostname = "control"
            control.vm.provision "file", source: "main.tf", destination: "/home/vagrant/main.tf"
            control.vm.provision "file", source: "playbook.yml", destination: "/home/vagrant/playbook.yml"
            control.vm.provision "file", source: "index.html", destination: "/home/vagrant/index.html"
            control.vm.provision "shell", path: "script.sh"
    end
end