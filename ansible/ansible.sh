#!/usr/bin/env bash

echo "ansible-server" > /etc/hostname
useradd ansibleadmin
#sed -i '/%wheel/a ansibleadmin       ALL=(ALL)     NOPASSWD: ALL' /etc/sudoers
#sed -i '/root/a ansibleadmin       ALL=(ALL)     NOPASSWD: ALL' /etc/sudoers
#sed -i '44a ansibleadmin       ALL=(ALL)     NOPASSWD: ALL' /etc/sudoers
#sed -i '/%admin/a ansibleadmin       ALL=(ALL)     NOPASSWD: ALL' /etc/sudoers

usermod -aG sudo ansibleadmin
usermod -s /bin/bash ansibleadmin
mkdir /home/ansibleadmin
cd /home
sudo chown -R ansibleadmin:ansibleadmin ansibleadmin
echo "permitRootLogin yes" >> /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

systemctl restart ssh

# Update to latest release
#
echo "Update installed software to latest release"
sudo apt update

# Install missing packages
#
echo "Install needed packages"
sudo apt install -y python-setuptools python3-pip ack-grep jq python-is-python3 python3-pip python-yaml python3-httplib2 python3-pysnmp4 tree

# Install Python components
#
echo "Install required Python components"
sudo pip3 install jinja2 six bracket-expansion netaddr scp

#
echo "Install optional Python components"
sudo pip3 install yamllint

# Install latest stable Ansible version from Ansible repository
#
echo "Install stable Ansible"
sudo apt install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt install -y ansible
sudo pip3 install paramiko

# Install additional tools for labs
#
echo "Install additional tools"
sudo apt install -y tree

usermod -aG docker ansibleadmin
