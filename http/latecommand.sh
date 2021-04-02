#!/bin/bash
mkdir -p --mode=0700 /home/vagrant/.ssh && curl -Lo /home/vagrant/.ssh/authorized_keys "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" && chmod 0600 /home/vagrant/.ssh/authorized_keys && chown -R vagrant:vagrant /home/vagrant/.ssh
mkdir -p --mode=0700 /root/.ssh && curl -Lo /root/.ssh/authorized_keys "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" && chmod 0600 /root/.ssh/authorized_keys && chown -R root:root /root/.ssh
sed -i "s/^#PermitRootLogin.*\$/PermitRootLogin prohibit-password/g" /etc/ssh/sshd_config
sed -i "s/^#PasswordAuthentication.*\$/PasswordAuthentication yes/g" /etc/ssh/sshd_config
apt-get -y remove linux-image-4.15*-hardened
apt-get -y install linux-image-5.4*-generic
cp /var/logs/syslog /root/syslog-install.log
systemctl enable ssh
