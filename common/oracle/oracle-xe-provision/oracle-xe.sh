#!/bin/bash

### http://blog.whitehorses.nl/2014/03/18/installing-java-oracle-11g-r2-express-edition-and-sql-developer-on-ubuntu-64-bit/
### https://docs.oracle.com/cd/E17781_01/install.112/e18802/toc.htm#XEINL124
echo ""
echo "---> Installing Oracle XE. "
mkdir -p /tmp/oracle-xe-xxx
mkdir -p /home/vagrant/shared/data/mysql

cd /tmp/oracle-xe-xxx
unzip /home/vagrant/shared/installers/oracle-xe-11.2.0-1.0.x86_64.rpm.zip
cd Disk1/
alien --scripts -d oracle-xe-11.2.0-1.0.x86_64.rpm

cp /home/vagrant/config/oracle-xe/chkconfig /sbin/chkconfig
sudo chmod 755 /sbin/chkconfig

cp /home/vagrant/config/oracle-xe/60-oracle.conf /etc/sysctl.d/60-oracle.conf
service procps start
sysctl -q fs.file-max
ln -s /usr/bin/awk /bin/awk
mkdir /var/lock/subsys
touch /var/lock/subsys/listener

dpkg --install oracle-xe_11.2.0-2_amd64.deb

rm -rf /dev/shm
mkdir /dev/shm
mount -t tmpfs shmfs -o size=768m /dev/shm

cp /home/vagrant/config/oracle-xe/S01shm_load /etc/rc2.d/S01shm_load
chmod 755 /etc/rc2.d/S01shm_load

cp /home/vagrant/config/oracle-xe/xe.rsp response/xe.rsp
sed -i "s/xORACLE_XE_HTTP_PORTx/$ORACLE_XE_HTTP_PORT/g" /tmp/oracle-xe-xxx/Disk1/response/xe.rsp
sed -i "s/xORACLE_XE_LISTENER_PORTx/$ORACLE_XE_LISTENER_PORT/g" /tmp/oracle-xe-xxx/Disk1/response/xe.rsp
sed -i "s/xORACLE_XE_ADMIN_PASSWORDx/$ORACLE_XE_ADMIN_PASSWORD/g" /tmp/oracle-xe-xxx/Disk1/response/xe.rsp
exec /etc/init.d/oracle-xe configure responseFile=/tmp/oracle-xe-xxx/Disk1/response/xe.rsp

rm -rf /etc/profile.d/oracle_env.sh
echo "export ORACLE_BASE=/u01/app/oracle" >> /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" >> /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
echo "export ORACLE_SID=XE" >> /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
echo "export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`" >> /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
echo "export PATH=$ORACLE_HOME/bin:$PATH" >> /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

cp /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh /etc/profile.d/oracle_env.sh
source /etc/profile.d/oracle_env.sh

if [ ! -f /etc/bash.bashrc.old ]
then
   cp /etc/bash.bashrc /etc/bash.bashrc.old
fi
cp /etc/bash.bashrc.old /tmp/oracle-xe-xxx/bash.bashrc.new

echo "" >> /tmp/oracle-xe-xxx/bash.bashrc.new
echo "" >> /tmp/oracle-xe-xxx/bash.bashrc.new
echo ". /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh" >> /tmp/oracle-xe-xxx/bash.bashrc.new
mv /tmp/oracle-xe-xxx/bash.bashrc.new /etc/bash.bashrc
rm -rf /tmp/oracle-xe*

sed -i -E "s/HOST = [^)]+/HOST = localhost/g" $ORACLE_HOME/network/admin/listener.ora
sed -i -E "s/HOST = [^)]+/HOST = localhost/g" $ORACLE_HOME/network/admin/tnsnames.ora

usermod -aG dba $SSH_USER_NAME
chown -R oracle:dba $ORACLE_HOME/dbs

service oracle-xe start

#--- use oracle user for creation of initial XE database
su - oracle
exec /u01/app/oracle/product/11.2.0/xe/bin/createdb.sh
sqlplus / as sysdba <<END
create user $DMB_DB_LOCAL_USER identified by $DMB_DB_LOCAL_PASSWORD;
grant connect to $DMB_DB_LOCAL_USER;
grant resource to $DMB_DB_LOCAL_USER;
grant create session to $DMB_DB_LOCAL_USER;
grant unlimited tablespace to dmblocal;
END
exit


cd $HOME