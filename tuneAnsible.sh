#!/bin/bash

sudo apt update
sudo apt install -y ansible

ansible --version
if [ $? -ne 0]
then
	echo "Не удалось установить Ansible."
	exit 1
fi

sudo sed -i "/host_key_checking =/s/.*/host_key_checking = False/" /etc/ansible/ansible.cfg

echo -e "\
[homework] \n\
sbrHW-VM1 ansible_host=192.168.207.101 \n\
sbrHW-VM2 ansible_host=192.168.207.102 \n\n\
[homework:vars] \n\
ansible_ssh_private_key_file=~/.ssh/vagrant.key \n\
ansible_python_interpreter=/usr/bin/python2.7 \n\
" > HWHosts

mkdir -p ~/.ansible/roles/java/tasks
mkdir -p ~/.ansible/roles/jenkins/tasks














---
- hosts: sbrHW-VM1
  become: true
  roles:
    - java
    - jenkins

- hosts: sbrHW-VM2
  become: true
  roles:
    - java





~/.ansible/roles/java/tasks/main.yml
---
- name: Устанавливаем java-11-openjdk-devel
  yum:
    name: java-11-openjdk-devel
    state: present
  when:
    ansible_os_family == "RedHat"
	
	
~/.ansible/roles/jenkins/tasks/main.yml	
---
- name: Download Jenkins repo
  get_url:
    url: https://pkg.jenkins.io/redhat-stable/jenkins.repo
    dest: /etc/yum.repos.d/jenkins.repo
    validate_certs: no


- name: Import jenkins key
  rpm_key:
    state: present
    key: https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    validate_certs: no

- name: Install epel
  yum:
    name: epel-release
    state: present

- name: Install jenkins
  yum:
    name: jenkins
    state: latest

- name: Start jenkins
  systemd:
    name: jenkins
    enabled: yes
    state: started












