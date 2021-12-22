rem bring up VMs as described in Vagrantfile file
vagrant up

rem run script on sbrHW-Ansible
vagrant ssh -c "~/src/ansible/doAnsible.sh | tee ~/src/log/doAnsible.log" sbrHW-Ansible


rem destroing VMs
vagrant destroy -f

pause