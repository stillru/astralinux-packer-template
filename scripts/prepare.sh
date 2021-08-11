#!/bin/bash -eux
whoami
echo "Generate sudo configuration..."
echo "vagrant" < /bin/sh -i /bin/su -P - --command "test -d /etc/sudoers.d && echo vagrant ALL=(ALL) NOPASSWD:ALL > /etc/sudoers.d/vagrant && chmod 0400 /etc/sudoers.d/vagrant"
echo "vagrant" | /bin/sh -i /bin/su -P - --command "test -d /etc/sudo.d && echo vagrant ALL=(ALL) NOPASSWD:ALL > /etc/sudo.d/vagrant && chmod 0400 /etc/sudo.d/vagrant"
echo Configure sshd...
#sed -i 's|.*PermitRootLogin.*|PermitRootLogin yes|g' /etc/openssh/sshd_config
echo "Update distribution..."
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo update-kernel -f -t el-smp
sudo apt-get install -y openssl-engines
sudo apt-get install -y kernel-modules-kvm-el-smp
sudo apt-get install -y qemu-guest-agent
sudo systemctl start qemu-guest-agent
echo "Enable ntpd..."
sudo chkconfig ntpd on
sudo apt-get install -y tzdata
echo "Configure ssh keys for vagrant..."
# Add a ssh config folder and authorized_keys file
mkdir /home/vagrant/.ssh
touch /home/vagrant/.ssh/authorized_keys
# Set owner and permissions
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
# Add the insecure public key, see https://github.com/mitchellh/vagrant/tree/master/keys
curl 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
echo "Finish!"
exit
sudo service sshd reload
