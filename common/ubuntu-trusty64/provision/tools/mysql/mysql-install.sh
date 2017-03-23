#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> Installing NySQL database"
apt-get -q -y install mysql-server-5.5
mkdir -p /home/vagrant/shared/data/mysql

echo ""
echo "---> Changing MySQL password"
exec mysqladmin -u $MYSQL_USER_NAME password $MYSQL_USER_PASSWORD
