#!/bin/bash -e

echo "Generate sudo configuration..."
#cat <<EOF > /home/vagrant/root
#!/bin/bash
test -d /etc/sudoers.d && echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant && chmod 0400 /etc/sudoers.d/vagrant
test -d /etc/sudo.d && echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudo.d/vagrant && chmod 0400 /etc/sudo.d/vagrant
#EOF
#chmod +x root
#cat /home/vagrant/root
echo "Generate su script..."
#cat <<EOF > /home/vagrant/su
#!/bin/bash

#/usr/bin/expect <<eof
#set timeout 20
#spawn su -l -c /home/vagrant/root
#expect "Password:"
#send "vagrant\r"
#eof
#EOF
echo "Execute su script..."
#cat /home/vagrant/su
#chmod +x /home/vagrant/su
#/home/vagrant/su
echo "Configure sshd..."
sed -i 's|.*PermitRootLogin.*|PermitRootLogin yes|g' /etc/openssh/sshd_config
echo "Reload sshd..."
service sshd reload
echo "Update distribution..."
apt-get update
apt-get -y dist-upgrade
update-kernel -f -t el-smp
apt-get install -y openssl-engines
apt-get install -y kernel-modules-kvm-el-smp
apt-get install -y qemu-guest-agent
systemctl start qemu-guest-agent
echo "Enable ntpd..."
chkconfig ntpd on
apt-get install -y tzdata
echo "Configure ssh keys for vagrant..."
# Add a ssh config folder and authorized_keys file
mkdir /home/vagrant/.ssh
touch /home/vagrant/.ssh/authorized_keys
# Set owner and permissions
chown -R vagrant /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
# Add the insecure public key, see https://github.com/mitchellh/vagrant/tree/master/keys
su vagrant
curl 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/vagrant/.ssh/authorized_keys
echo "Finish!"
exit
