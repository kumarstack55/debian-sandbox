# -*- mode: ruby -*-
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 22, host: 10022, host_ip: "127.0.0.1"
  config.vm.synced_folder "data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = "4096"
  end
  config.vm.provision "shell", path: "data/provision.sh"
end
