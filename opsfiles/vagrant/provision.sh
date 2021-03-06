#!/bin/bash

set -x

apt_install_ansible()
{
  ### input grub-pc setting
  echo "set grub-pc/install_devices /dev/sda" | debconf-communicate

  ### update ubuntu
  apt-get install -f

  ### install ansible
  # 'vivid is Ubuntu 15.4', 'wily is 15.10', 'xenial is 16.04'
  CODENAME='xenial'
  apt install -y software-properties-common
  apt-add-repository ppa:ansible/ansible
  apt-get update
  apt-get install -y ansible
}

### install ansible
apt_install_ansible

### ansible-playbook 
playbook_dir='/develop/gitlab-dev/opsfiles/vagrant/playbook'
if [ "$1" = "rancher" ]; then
  ansible-playbook        -i ${playbook_dir}/vagrant ${playbook_dir}/webserver-rancher.yaml
else
  ansible-playbook        -i ${playbook_dir}/vagrant ${playbook_dir}/webserver.yaml
fi

rm -rfv ${playbook_dir}/webserver.retry
