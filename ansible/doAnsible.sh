#!/bin/bash

function die() {
  echo "ERROR while $1 (${BASH_SOURCE[1]}:${FUNCNAME[1]} line ${BASH_LINENO[0]})" >&2
  exit 1
}

echo "--- install Ansible ---"

sudo apt update 
sudo apt install -y ansible
ansible --version \
|| die "install ansible"


sudo sed -i "/host_key_checking =/s/.*/host_key_checking = False/" /etc/ansible/ansible.cfg \
|| die "config ansible"


echo "--- setup roles ---"

mkdir -p ~/.ansible/roles/java/tasks \
&& ln -s ~/src/ansible/role.java.yml ~/.ansible/roles/java/tasks/main.yml \
|| die "setup 'java' role"


mkdir -p ~/.ansible/roles/jenkins/tasks \
&& ln -s ~/src/ansible/role.jenkins.yml ~/.ansible/roles/jenkins/tasks/main.yml \
|| die "setup 'jenkins' role"

cp ~/src/keys/vagrant.key ~/.ssh/vagrant.key \
&& chmod 400  ~/.ssh/vagrant.key \
|| die "change private key file mode"

ls -la ~/src/keys/

echo "--- play infrastructure playbook ---"

ansible-playbook ~/src/ansible/play.sbrHW.yml \
  -i ~/src/ansible/hosts.sbrHW \
  | tee ~/src/log/play.sbrHW.log \
|| die "playing play.sbrHW.yml"

echo "--- play task playbook ---"

ansible-playbook ~/src/ansible/play.task.yml \
  -i ~/src/ansible/hosts.sbrHW \
  | tee ~/src/log/play.task.log \
|| die "playing play.task.yml"
