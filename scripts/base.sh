#!/bin/bash -ex

cat <<EOF > /home/vagrant/root
#!/bin/bash
test -d /etc/sudoers.d && echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant && chmod 0400 /etc/sudoers.d/vagrant
test -d /etc/sudo.d && echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudo.d/vagrant && chmod 0400 /etc/sudo.d/vagrant
EOF
chmod +x root

cat <<EOF > /home/vagrant/su
#!/bin/expect
set timeout 20
spawn su -l -c /home/vagrant/root
expect "Password:"
send "vagrant\r"
expect eof
EOF

chmod +x /home/vagrant/su
/home/vagrant/su

sudo sed -i 's|.*PermitRootLogin.*|PermitRootLogin yes|g' /etc/openssh/sshd_config
sudo service sshd reload

sudo apt-get update
sudo apt-get -y dist-upgrade
sudo update-kernel -f -t el-smp
sudo apt-get install -y openssl-engines
sudo apt-get install -y kernel-modules-kvm-el-smp 

sudo grep -q '^openssl_conf' /etc/openssl/openssl.cnf || sudo sed -i '1iopenssl_conf = openssl_def' /etc/openssl/openssl.cnf
sudo tee -a /etc/openssl/openssl.cnf <<EOF

[openssl_def]
engines = engine_section

[engine_section]
gost = gost_section

[gost_section]
engine_id = gost
default_algorithms = ALL
CRYPT_PARAMS = id-Gost28147-89-CryptoPro-A-ParamSet

EOF

echo $(openssl ciphers|tr ':' '\n'|grep GOST)

sudo chkconfig ntpd on
sudo apt-get install -y tzdata
sudo rm -f /home/vagrant/su /home/vagrant/root

