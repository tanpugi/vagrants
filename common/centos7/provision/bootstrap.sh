#!/bin/bash
echo ""
echo "---> Using root access. "
#sudo su

### Initialization for provision
#. /home/vagrant/provision/init-config.sh
#. /home/vagrant/provision/init/proxy.sh
#. /home/vagrant/provision/init/common-tools.sh
#. /home/vagrant/provision/init/certificates-install.sh


### Applications
#. /home/vagrant/provision/tools/oracle-jdk7/oracle-jdk7.sh
#. /home/vagrant/provision/tools/memcached/memcached-install.sh

### Build Tools
#. /home/vagrant/provision/tools/docker/docker-install.sh
#. /home/vagrant/provision/tools/git/git-install.sh
#. /home/vagrant/provision/tools/maven/maven-install.sh
#. /home/vagrant/provision/tools/npm/npm-install.sh

### Cleanup
#. /home/vagrant/provision/bootstrap-cleanup.sh

echo ""
echo "---> Exit sudo user"
#exit

echo ""
echo "---> DONE"

