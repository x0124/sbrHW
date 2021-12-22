# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  

  # add shared public key to vagrant user on all machines
  config.vm.provision "shell" do |sh|
    sshPublicKey = File.readlines("keys\\vagrant.pub").first.strip
    sh.inline = "echo #{sshPublicKey} >> /home/vagrant/.ssh/authorized_keys"
  end

  config.vm.define "sbrHW-Ansible" do |machine|
    machine.vm.provider "virtualbox" do |vb|
	    vb.name = "sbrHW-Ansible"
      vb.memory = 1024
      vb.cpus = 2
    end
	
	  machine.vm.box = "generic/ubuntu2004"
	  machine.vm.hostname = "sbrHW-Ansible"
	  machine.vm.network :private_network, ip: "192.168.207.100"
    
    # map project folder to ansible machine
    machine.vm.synced_folder ".", "/home/vagrant/src"
  end

  config.vm.define "sbrHW-VM1" do |machine|
    machine.vm.provider "virtualbox" do |vb|
	    vb.name = "sbrHW-VM1"
      vb.memory = 1024
      vb.cpus = 2
    end
	
    machine.vm.box = "centos/7"
    machine.vm.hostname = "sbrHW-VM1"
    machine.vm.network :private_network, ip: "192.168.207.101"
  end

  config.vm.define "sbrHW-VM2" do |machine|
    machine.vm.provider "virtualbox" do |vb|
  	  vb.name = "sbrHW-VM2"
      vb.memory = 1024
      vb.cpus = 2
    end
	
    machine.vm.box = "centos/7"
    machine.vm.hostname = "sbrHW-VM2"
    machine.vm.network :private_network, ip: "192.168.207.102"
  end

end