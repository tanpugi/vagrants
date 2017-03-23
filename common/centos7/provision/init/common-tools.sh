#!/bin/bash

echo ""
echo "---> Installing additional OS common tools"
apt-get --yes --force-yes install apt-transport-https ca-certificates
apt-get --yes --force-yes install g++
apt-get --yes --force-yes install alien libaio1 unixodbc vim
apt-get --yes --force-yes install libevent-dev
apt-get --yes --force-yes install gedit
apt-get --yes --force-yes install graphicsmagick