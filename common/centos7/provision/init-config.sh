#!/bin/bash
echo ""
echo "---> ATTENTION: "
echo "---> Always change directory to script home."
echo "---> To insure accidental rm -rf of all directories."

mkdir -p /home/vagrant/shared/data
mkdir -p /home/vagrant/shared/repository
mkdir -p /home/vagrant/shared/temp

rm -rf /tmp/tempFile
  
echo ""
echo "---> Setting Configurations"
. /home/vagrant/config/config-bootstrap.sh
cat /home/vagrant/config/config-bootstrap.sh
cat /home/vagrant/config/config-bootstrap.sh >> /tmp/tempFile

SCRIPT_HOME_DIR=/home/$SSH_USER_NAME
cp /etc/environment /etc/environment.copy
sed -i '/^SCRIPT_HOME_DIR/d' /etc/environment.copy
echo "SCRIPT_HOME_DIR=\"$SCRIPT_HOME_DIR\"" >> /etc/environment.copy
mv /etc/environment.copy /etc/environment

source /etc/environment

cd $SCRIPT_HOME_DIR