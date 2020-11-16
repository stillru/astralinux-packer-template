#!/bin/bash -eux
#Copyright 2020, Stepan Illichevsky (<still.ru@gmail.com>)
#Copyright 2012-2014, Chef Software, Inc. (<legal@chef.io>)
#Copyright 2011-2012, Tim Dysinger (<tim@dysinger.net>)

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

echo "Remove unnessesary packages"
apt-get --yes clean

echo "Clean empty space"
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history
find /var/log -type f | while read f; do echo -ne '' > $f; done;

echo "Whiteout root"
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

echo "Whiteout /boot"
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

echo "Clean swap"
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;

echo "Fill filesystem with 0 to reduce box size"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync

systemctl poweroff
