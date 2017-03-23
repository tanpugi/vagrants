#!/bin/bash
echo ""
echo "---> Creating user(with sudo privileges)" 
echo "SSH_USER_NAME=$SSH_USER_NAME"
echo "SSH_USER_PASSWORD=$SSH_USER_PASSWORD"
echo "SSH_USER_GROUP=$SSH_USER_GROUP"
sudoers_file=/etc/sudoers.d/$SSH_USER_NAME
sudoers_tmp=temp_custom_sudoers_file
rm -rf $sudoers_tmp
echo "$SSH_USER_GROUP ALL=(ALL:ALL) NOPASSWD:ALL" > $sudoers_tmp
echo "Defaults  env_keep += \"http_proxy\"" >> $sudoers_tmp
echo "Defaults  env_keep += \"https_proxy\"" >> $sudoers_tmp
echo "Defaults  env_keep += \"HTTP_PROXY\"" >> $sudoers_tmp
echo "Defaults  env_keep += \"HTTPS_PROXY\"" >> $sudoers_tmp
echo "Defaults  env_keep += \"no_proxy\"" >> $sudoers_tmp
chmod 0440 $sudoers_tmp
rm -rf $sudoers_file
mv $sudoers_tmp $sudoers_file

echo ""
echo "---> Setting Proxy"
echo "PROXY=$PROXY"
export http_proxy="$PROXY"
export https_proxy="$PROXY"
export HTTP_PROXY="$PROXY"
export HTTPS_PROXY="$PROXY"
export no_proxy="localhost, *.fxdms.net, 192.168.*, 10.*, 127.0.*"

echo "export http_proxy=\"$PROXY\"" > /etc/profile.d/proxy.sh
echo "export https_proxy=\"$PROXY\"" >> /etc/profile.d/proxy.sh
echo "export HTTP_PROXY=\"$PROXY\"" >> /etc/profile.d/proxy.sh
echo "export HTTPS_PROXY=\"$PROXY\"" >> /etc/profile.d/proxy.sh
echo "export no_proxy=\"localhost, *.fxdms.net\"" >> /etc/profile.d/proxy.sh

source /etc/profile.d/proxy.sh

echo ""
echo "---> Disabling Firewall"
ufw disable
ufw status
if [ ! -f /etc/default/ufw.default.old ]
then
	cp /etc/default/ufw /etc/default/ufw.default.old
fi
cp /etc/default/ufw.default.old /home/vagrant/ufw.copy
sed -i 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /home/vagrant/ufw.copy

cp /home/vagrant/ufw.copy /etc/default/ufw
rm /home/vagrant/ufw.copy

