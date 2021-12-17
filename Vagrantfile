# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = {
  "sbrHWHostAnsible" => {
	"box"  => "generic/ubuntu2004",
	"ip"   => "192.168.33.12"
  }
}


Vagrant.configure("2") do |config|
  hosts.each do |name,param|
    config.vm.define name do |machine|
	
      machine.vm.provider "virtualbox" do |v|
          v.name = name
          v.customize ["modifyvm", :id, "--memory", 512]
      end


      machine.vm.box = param["box"]
      machine.vm.hostname = "%s" % name
      machine.vm.network :private_network, ip: param["ip"]
	  
	  config.vm.synced_folder ".", "/sbrHW"
	  

    end
  end
end
  