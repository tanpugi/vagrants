#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> Installing git"
apt-get --yes --force-yes install git

echo ""
echo "---> Configuring git"
git config --global url."https://".insteadOf git://
git config --global http.proxy $http_proxy
git config --global https.proxy $https_proxy
echo '[http "http://source.fxdms.net"]' >> /root/.gitconfig
echo -e "\tproxy = " >> /root/.gitconfig