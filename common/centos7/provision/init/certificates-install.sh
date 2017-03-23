echo ""
echo "---> Adding FXDMS CA Certificates (and ROOT) to CA Truststore"
if [ ! -f /etc/ca-certificates.conf.default.old ]
then
	cp /etc/ca-certificates.conf /etc/ca-certificates.conf.default.old
fi

rm -rf /usr/share/ca-certificates/dmb
mkdir /usr/share/ca-certificates/dmb

cp /home/vagrant/config/ssl/FXDMS-CA.pem FXDMS-CA.crt
cp FXDMS-CA.crt /usr/share/ca-certificates/dmb
rm -rf FXDMS-CA.crt

cp /home/vagrant/config/ssl/ROOT-CA.pem ROOT-CA.crt
cp ROOT-CA.crt /usr/share/ca-certificates/dmb
rm -rf ROOT-CA.crt

dpkg-reconfigure -f noninteractive ca-certificates

cp /etc/ca-certificates.conf.default.old /etc/ca-certificates.conf

echo "dmb/FXDMS-CA.crt" >> /etc/ca-certificates.conf
echo "dmb/ROOT-CA.crt" >> /etc/ca-certificates.conf

dpkg-reconfigure -f noninteractive ca-certificates