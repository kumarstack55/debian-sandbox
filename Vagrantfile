# -*- mode: ruby -*-
Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true

  # VirtualBox Guest Additions が導入済みの box を選択する。
  # Inspiron 5502/5509 + Windows + VirtualBox 6.1.34 で
  # debian/bullseye64, debian/buster64 を試したところ、
  # vagrant up でタイムアウトが複数発生し失敗した。
  # 調べてみると Call Stack が頻繁に /var/log/messages に出力されていた。
  # VirtualBox Guest Additions の導入後に不安定になっているように見える。
  # そのため、 VirtualBox Guest Additions が導入済みの box を選択する。
  #config.vm.box = "debian/bullseye64"
  #config.vm.box = "debian/buster64"
  config.vm.box = "debian/contrib-buster64"

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 22, host: 10022, host_ip: "127.0.0.1"

  #config.vm.synced_folder "data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
    # VirtualBox Guest Additions の導入後に不安定になりそうなので、
    # 更新したくなく、チェックも不要と設定する。
    vb.check_guest_additions = false

    #vb.gui = true

    vb.name = "vagrant-debian"

    # Inspiron 5502/5509 で試しに cpus = 1 にしたところ、
    # debian/bullseye64 が kernel panic となった。
    # 2 以上の値を指定する。
    vb.cpus = 2

    vb.memory = 4096
  end
  config.vm.provision "shell", path: "data/provision.sh"
end
