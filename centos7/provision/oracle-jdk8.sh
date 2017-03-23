echo "---> Running /provision/oracle-jdk8.sh <---"
echo "---> Removing temporary data"
rm /tmp/jdk-8u121-linux-x64.tar.gz

echo ""
echo "---> Downloading jdk8u121 tar.gz file"
curl -o /tmp/jdk-8u121-linux-x64.tar.gz -LO -H  "Cookie: oraclelicense=accept-securebackup-cookie" -k http://download.oracle.com/otn-pub/java/jdk/8u121-b13/jdk-8u121-linux-x64.tar.gz
