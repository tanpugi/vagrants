#!/bin/bash

SSH_PORT=$1
DOCKER_PORT=$2

echo ""
echo "---> Securing SSH access" 
if [ ! -f /etc/ssh/sshd_config.default.old ]
then
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.default.old 
fi
cp /etc/ssh/sshd_config.default.old /home/vagrant/sshd_config.copy
sed -i "s/Port 22/Port $SSH_PORT/g" /home/vagrant/sshd_config.copy
sed -i "s/PermitRootLogin without-password/PermitRootLogin no/g" /home/vagrant/sshd_config.copy

cp /home/vagrant/sshd_config.copy /etc/ssh/sshd_config
rm /home/vagrant/sshd_config.copy

service ssh restart

echo ""
echo "---> Enabling Firewall for Installations"
ufw reload
ufw allow $SSH_PORT/tcp
ufw allow $DOCKER_PORT/tcp
ufw default deny incoming
ufw default allow outgoing
ufw --force enable
ufw status

apt-get --yes --force-yes clean all