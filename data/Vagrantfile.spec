# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://docs.vagrantup.com.

Vagrant.configure(2) do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.socket = "/var/run/libvirt/libvirt-sock"
    #libvirt.host = "localhost"
    #libvirt.username = ""
    #libvirt.password = ""
    #libvirt.id_ssh_key_file = "$HOME/.ssh/id_rsa"
    #libvirt.uri = ""
  end

  config.vm.define :vm1 do |vm1|
    #vm1.vm.box = "centos-7-server-x86_64"
    #vm1.vm.provision :shell, path: "bootstrap.sh"
    #vm1.vm.network :forwarded_port, guest: 80, host: 4567
    #vm1.vm.synced_folder './', '/vagrant', type: 'rsync'

    vm1.vm.provider :libvirt do |domain|
      domain.driver = "kvm"
      #domain.memory = 512
      #domain.cpus = 1
      #domain.nested = true
      #domain.boot 'network'
      #domain.boot 'hd'

      #domain.storage :file, :size => '5G', :type => "raw"
      #domain.storage :file, :device => 'cdrom', :path => "/mnt/linux.iso"
      #domain.graphics_port = 5901
      #domain.graphics_ip = '0.0.0.0'
    end
  end
end
