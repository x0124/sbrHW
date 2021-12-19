# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = {
  "sbrHW-Ansible" => {
	"box"  => "generic/ubuntu2004",
	"ip"   => "192.168.207.100"
  },
 "sbrHW-VM1" => {
	"box"  => "centos/7",
	"ip"   => "192.168.207.101"
 },
  "sbrHW-VM2" => {
	"box"  => "generic/rhel7",
	"ip"   => "192.168.207.102"
  }
}


Vagrant.configure("2") do |config|

  
  config.vm.provision "shell" do |sh|
    sshPublicKey = File.readlines("keys\\vagrant.pub").first.strip
    sshPrivateKey = File.readlines("keys\\vagrant.key").first.strip
    sh.inline = <<-SHELL
      echo #{sshPublicKey} >> /home/vagrant/.ssh/authorized_keys
	  echo #{sshPrivateKey} > /home/vagrant/vagrant.key
	  chmod 400 /home/vagrant/vagrant.key
    SHELL
  end
  
  hosts.each do |name, params|  
    config.vm.define name do |machine|
	  machine.vm.provider "virtualbox" do |vb|
	    vb.name = name
	    vb.memory = 512
	    vb.cpus = 1
	  end
	  machine.vm.box = params["box"]
	  machine.vm.hostname = "%s" % name
	  machine.vm.network :private_network, ip: params["ip"]
    end
  end

end