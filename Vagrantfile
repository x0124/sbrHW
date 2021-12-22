# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  

  # add my own public key to vagrant user on all machines
  config.vm.provision "shell" do |sh|
    sshPublicKey = File.readlines("keys\\vagrant.pub").first.strip
    sh.inline = "echo #{sshPublicKey} >> /home/vagrant/.ssh/authorized_keys"
  end

  config.vm.define "sbrHW-Ansible" do |machine|
    machine.vm.provider "virtualbox" do |vb|
	    vb.name = "sbrHW-Ansible"
      vb.memory = 512
      vb.cpus = 1
    end
	
	  machine.vm.box = "generic/ubuntu2004"
	  machine.vm.hostname = "sbrHW-Ansible"
	  machine.vm.network :private_network, ip: "192.168.207.100"
	
    machine.vm.synced_folder ".", "/home/vagrant/src"

    machine.vm.provision "file", source: "keys\\vagrant.key", destination: "/home/vagrant/.ssh/vagrant.key" 
    machine.vm.provision "shell", inline: "chmod 400 /home/vagrant/.ssh/vagrant.key"
  end

  config.vm.define "sbrHW-VM1" do |machine|
    machine.vm.provider "virtualbox" do |vb|
	    vb.name = "sbrHW-VM1"
      vb.memory = 1024
      vb.cpus = 1
    end
	
    machine.vm.box = "centos/7"
    machine.vm.hostname = "sbrHW-VM1"
    machine.vm.network :private_network, ip: "192.168.207.101"
  end

  config.vm.define "sbrHW-VM2" do |machine|
    machine.vm.provider "virtualbox" do |vb|
  	  vb.name = "sbrHW-VM2"
      vb.memory = 512
      vb.cpus = 1
    end
	
    machine.vm.box = "centos/7"
    machine.vm.hostname = "sbrHW-VM2"
    machine.vm.network :private_network, ip: "192.168.207.102"
  end

end