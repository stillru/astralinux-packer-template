# Set up Vagrant.

echo $(date +%d-%m-%Y) builded > /etc/vagrant_box_build_time

# Customize the message of the day
echo 'Welcome to your Vagrant-built virtual machine.' > /var/run/motd
cat << EOF >> /etc/bash.bashrc
REGION="vagrant-astra"
if [[ 0 == 0 ]]
  then
    PS1='[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;31m\]\u:\[\033[1;31m\]\w\[\033[00m\]]:# '
  else
    PS1='[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;32m\]\u:\[\033[1;32m\]\w\[\033[00m\]]:$ '
fi
EOF

cat << EOF >> /home/vagrant/.bashrc
REGION="vagrant-astra"
if [[ $UID == 0 ]]
  then
    PS1='[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;31m\]\u:\[\033[1;31m\]\w\[\033[00m\]]:# '
  else
    PS1='[\[\033[1;32m\]$REGION\[\033[00m\]|\[\033[1;32m\]\u:\[\033[1;32m\]\w\[\033[00m\]]:$ '
fi
EOF
