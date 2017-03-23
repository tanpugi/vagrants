#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> Installing Memcached"
apt-get install --yes --force-yes memcached
service memcached restart