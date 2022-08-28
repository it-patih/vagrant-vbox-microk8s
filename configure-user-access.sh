#!/bin/bash

echo "###"
echo "### configure-user-access.sh ### "
echo "###"

NOW=$(date +"%Y%m%d-%H%M%S")

echo "> Backup /home/vagrant/.ssh/authorized_keys"
cp /home/vagrant/.ssh/authorized_keys /home/vagrant/.ssh/authorized_keys.$NOW
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys.$NOW

echo "> Add public key of operator to login to user vagrant"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCc/JpeqhJWZIPjqakdjLu2PcuS/aEV8RYHeJj+R4q+nIHYNVMiC8f7y2oeWSgHebrUFqoRG9Le0GNf0TXtSIafjNPNCvOvLhZX+ghNozFJ47OUfjeGGv26al+bF2tzS9ETqmmFI7gTTGrP5j+D9BG3k6RMrWHSU+3oSFJxnthMeCqa7SWPxmLZ94cUF3HYhXE8P/Bfw7bkyMY8SC1zA9o2vag2qdoKFJN3LE4KxRX3MTG6H4gfVy5z8o+4taF3W/hspcmRxOUN7YDwh+Q2CPDLDkqXheqQePXaGAdqmwf0atdI4hjA7kvqcQeGIgRRg36luUVonivJc3Ht7wnlup/t operator" >> /home/vagrant/.ssh/authorized_keys

echo "> Create and configure new user microk8s"
useradd -m -s /bin/bash microk8s
ssh-keygen -q -t rsa -N '' -f /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub
mkdir /home/microk8s/.ssh
chown microk8s:microk8s /home/microk8s/.ssh
cp /home/vagrant/.ssh/id_rsa.pub /home/microk8s/.ssh/authorized_keys
chown microk8s:microk8s /home/microk8s/.ssh/authorized_keys
usermod -aG sudo microk8s

echo "> Backup /home/microk8s/.ssh/authorized_keys"
cp /home/vagrant/.bashrc /home/microk8s/.ssh/bashrc.$NOW
chown microk8s:microk8s /home/microk8s/.ssh/bashrc.$NOW
