#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> Installing nodejs"
wget http://nodejs.org/dist/v5.4.1/node-v5.4.1-linux-x64.tar.gz
tar --strip-components 1 -xzvf node-v* -C /usr/local
rm node-v5.4.1-linux-x64.tar.gz
npm rm npm -g

echo ""
echo "---> Installing latest version of npm"
. /home/vagrant/provision/tools/npm/npm-install-script.sh

echo ""
echo "---> Configuring npm"
sudo npm config set proxy $http_proxy -g
sudo npm config set https-proxy $https_proxy -g
sudo npm config set cafile /etc/ssl/certs/ca-certificates.crt -g
sudo npm config set registry "http://registry.npmjs.org/" -g
sudo npm set strict-ssl true -g
sudo npm install -g grunt-cli
sudo npm install -g bower