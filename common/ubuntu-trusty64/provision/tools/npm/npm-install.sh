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
npm config set proxy $http_proxy -g
npm config set https-proxy $https_proxy -g
npm config set cafile /etc/ssl/certs/ca-certificates.crt -g
npm config set registry "http://registry.npmjs.org/" -g
npm set strict-ssl true -g
npm install -g grunt-cli
npm install -g bower