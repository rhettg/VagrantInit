# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.hostname = "vinit-demo"

  # Unidirectional rsync folder
  config.vm.synced_folder "./vinit", "/var/vinit", type: "rsync"
  config.vm.provision "shell", inline: "/var/vinit/vinit.sh"
end
