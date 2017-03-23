#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> Installing/Configuring maven"
mkdir /opt/maven
tar -zxvf /home/vagrant/installers/apache-maven-3.3.9-bin.tar.gz -C /opt/maven

MAVEN_HOME=/opt/maven/apache-maven-3.3.9
cp /etc/environment /etc/environment.copy
sed -i '/^MAVEN_HOME/d' /etc/environment.copy
echo "MAVEN_HOME=\"$MAVEN_HOME\"" >> /etc/environment.copy
sed -i "s|:${MAVEN_HOME}/bin||g" /etc/environment.copy
sed -i "s|${PATH}|${PATH}:${MAVEN_HOME}/bin|g" /etc/environment.copy
mv /etc/environment.copy /etc/environment

source /etc/environment

mkdir -p /home/vagrant/shared/repository/m2
if [ ! -f $MAVEN_HOME/conf/settings.xml.old ]
then
	cp $MAVEN_HOME/conf/settings.xml $MAVEN_HOME/conf/settings.xml.old
fi
cp /home/vagrant/config/maven/settings.xml $MAVEN_HOME/conf/settings.xml

