#!/bin/bash

function die() {
  echo "ERROR while $1 (${BASH_SOURCE[1]}:${FUNCNAME[1]} line ${BASH_LINENO[0]})" >&2
  exit 1
}

if false; then

sudo apt update 
sudo apt install -y ansible
ansible --version \
|| die "install ansible"

fi

sudo sed -i "/host_key_checking =/s/.*/host_key_checking = False/" /etc/ansible/ansible.cfg \
|| die "config ansible"


mkdir -p ~/.ansible && cd ~/.ansible && echo -e "\
[homework] \n\
sbrHW-VM1 ansible_host=192.168.207.101 \n\
sbrHW-VM2 ansible_host=192.168.207.102 \n\n\
[homework:vars] \n\
ansible_ssh_private_key_file=~/.ssh/vagrant.key \n\
ansible_python_interpreter=/usr/bin/python2.7 \n\
" > hosts.sbrHW \
|| die "create hosts file"


mkdir -p roles/java/tasks && echo -e "\
--- \n\
- name: install java-11-openjdk-devel \n\
  yum: \n\
    name: java-11-openjdk-devel \n\
    state: present \n\
  when: \n\
    ansible_os_family == \"RedHat\" \n\
" > roles/java/tasks/main.yml \
|| die "create 'java' role"


mkdir -p roles/jenkins/tasks && echo -e "\
--- \n\
- name: download Jenkins repo \n\
  get_url: \n\
    url: https://pkg.jenkins.io/redhat-stable/jenkins.repo \n\
    dest: /etc/yum.repos.d/jenkins.repo \n\
    validate_certs: no \n\
 \n\
- name: import jenkins key \n\
  rpm_key: \n\
    state: present \n\
    key: https://pkg.jenkins.io/redhat-stable/jenkins.io.key \n\
    validate_certs: no \n\
 \n\
- name: install epel \n\
  yum: \n\
    name: epel-release \n\
    state: present \n\
 \n\
- name: install jenkins \n\
  yum: \n\
    name: jenkins \n\
    state: latest \n\
 \n\
- name: start jenkins \n\
  systemd: \n\
    name: jenkins \n\
    enabled: yes \n\
    state: started \n\
" > roles/jenkins/tasks/main.yml \
|| die "create 'jenkins' role"


echo -e "\
--- \n\
- hosts: sbrHW-VM2 \n\
  become: true \n\
  roles: \n\
    - java \n\
 \n\
- hosts: sbrHW-VM1 \n\
  become: true \n\
  roles: \n\
    - java \n\
    - jenkins \n\
" > playbook.sbrHW.yml \
|| die "create playbook"


ansible-playbook playbook.sbrHW.yml -i hosts.sbrHW \
|| die "playing playbook"

exit 0









