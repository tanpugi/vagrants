#!/bin/bash
cd $SCRIPT_HOME_DIR

echo ""
echo "---> This OS has already an OpenJDK 7 Pre-installed. "
java -version | echo

echo ""
echo "---> Adding Oracle JDK 7. "
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
mkdir /opt/jdk
tar -zxvf /home/vagrant/jdk-7u80-linux-x64.tar.gz -C /opt/jdk
update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.7.0_80/bin/java 100
update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.7.0_80/bin/java 100
rm /home/vagrant/jdk-7u80-linux-x64.tar.gz

echo ""
echo "---> Verifying Oracle JDK 7 is installed as alternative. "
update-alternatives --display java
update-alternatives --display javac
java -version

JAVA_HOME=/opt/jdk/jdk1.7.0_80
cp /etc/environment /etc/environment.copy
sed -i '/^JAVA_HOME/d' /etc/environment.copy
echo "JAVA_HOME=\"$JAVA_HOME\"" >> /etc/environment.copy
sed -i "s|:${JAVA_HOME}/bin||g" /etc/environment.copy
sed -i "s|${PATH}|${PATH}:${JAVA_HOME}/bin|g" /etc/environment.copy
mv /etc/environment.copy /etc/environment

source /etc/environment
