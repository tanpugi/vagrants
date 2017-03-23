#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> Installing docker"
apt-get --yes --force-yes install docker.io

echo ""
echo "---> Installing docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo ""
echo "---> Configuring docker. Creating user group for docker"
docker_defaults_file=/etc/default/docker
rm -rf $docker_defaults_file
echo "export http_proxy=\"$PROXY/\"" > $docker_defaults_file
echo "export https_proxy=\"$PROXY/\"" >> $docker_defaults_file
echo "export HTTP_PROXY=\"$PROXY/\"" >> $docker_defaults_file
echo "export HTTPS_PROXY=\"$PROXY/\"" >> $docker_defaults_file

docker_config_dir=/etc/systemd/system/docker.service.d
rm -rf $docker_config_dir
mkdir $docker_config_dir
chown -R $SSH_USER_GROUP:$SSH_USER_NAME $docker_config_dir
echo "Environment=\"http_proxy=$PROXY\"" > $docker_config_dir/http-proxy.conf
echo "Environment=\"https_proxy=$PROXY\"" >> $docker_config_dir/http-proxy.conf
echo "Environment=\"HTTP_PROXY=$PROXY\"" >> $docker_config_dir/http-proxy.conf
echo "Environment=\"HTTPS_PROXY=$PROXY\"" >> $docker_config_dir/http-proxy.conf
echo "Environment=\"NO_PROXY=localhost, *.fxdms.net\"" >> $docker_config_dir/http-proxy.conf

usermod -aG docker $SSH_USER_NAME

echo ""
echo "---> Starting docker. Service automatically runs on reboot. Checking if docker is properly installed"
service docker restart
update-rc.d docker defaults

echo ""
echo "---> Checking if docker is properly installed."
docker pull hello-world
docker run hello-world