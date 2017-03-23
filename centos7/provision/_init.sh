echo "---> Running /provision/init.sh <---"

echo ""
echo "---> Disabling firewall"
systemctl stop firewalld 
systemctl disable firewalld

echo ""
echo "---> Setting SELinux to Permissive"
setenforce 0