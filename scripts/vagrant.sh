# Set up Vagrant.

echo $(date +%d-%m-%Y) builded > /etc/vagrant_box_build_time

# Create the user vagrant with password vagrant
#useradd -G sudo -p $(perl -e'print crypt("vagrant", "vagrant")') -m -s /bin/bash -N vagrant

# Create ssh folders

# Install vagrant keys
#mkdir -pm 700 /home/vagrant/.ssh
#curl -Lo /home/vagrant/.ssh/authorized_keys \
#  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
#chmod 0600 /home/vagrant/.ssh/authorized_keys
#chown -R vagrant:vagrant /home/vagrant/.ssh

#mkdir -pm 700 /root/.ssh
#curl -Lo /root/.ssh/authorized_keys \
#  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
#chmod 0600 /root/.ssh/authorized_keys
#chown -R root:root /root/.ssh

# Customize the message of the day
echo 'Welcome to your Vagrant-built virtual machine.' > /var/run/motd
cat << EOF >> /etc/bash.bashrc
REGION='\h'
if [[ $UID == 0 ]]
  then
    PS1="[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;31m\]\u:\[\033[1;31m\]\w\[\033[00m\]]:# "
  else
    PS1="[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;32m\]\u:\[\033[1;32m\]\w\[\033[00m\]]:$ "
fi
EOF

cat << EOF >> /home/vagrant/.bashrc
REGION='\h'
if [[ $UID == 0 ]]
  then
    PS1="[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;31m\]\u:\[\033[1;31m\]\w\[\033[00m\]]:# "
  else
    PS1="[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;32m\]\u:\[\033[1;32m\]\w\[\033[00m\]]:$ "
fi
EOF
