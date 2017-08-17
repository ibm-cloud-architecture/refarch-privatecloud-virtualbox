echo =================================================================
echo Pulling ICp image
sudo docker pull ibmcom/cfc-installer:1.2.0

echo =================================================================
echo Configuring ICp
cd /opt
sudo docker run -e LICENSE=accept --rm -v "$(pwd)":/data ibmcom/cfc-installer:1.2.0 cp -r cluster /data

echo =================================================================
echo Extracting the image
cd /opt
sudo docker run -e LICENSE=accept --rm -v "$(pwd)":/data ibmcom/cfc-installer:1.2.0 cp -r cluster /data

echo =================================================================
echo Obtaining IP address
export IP_ADDRESS=`hostname -I | cut -d' ' -f1`
echo IP address: $IP_ADDRESS

echo =================================================================
echo Configuring ICp hosts file
export HOSTS=/opt/cluster/hosts
sudo cp $HOSTS $HOSTS.original
sed s/IP_ADDRESS/$IP_ADDRESS/ /vagrant/hosts > /tmp/hosts
sudo cp /tmp/hosts $HOSTS

echo =================================================================
echo Configuring ICp hosts file
export HOSTS=/etc/hosts
sudo cp $HOSTS $HOSTS.original
printf "$IP_ADDRESS\tvagrant\n" | cat - $HOSTS >> /tmp/hosts
sudo cp /tmp/hosts $HOSTS


echo =================================================================
echo Installing ICp
cd /opt/cluster
sudo cp ~/.ssh/id_rsa /opt/cluster/ssh_key
sudo chmod 400 /opt/cluster/ssh_key

sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster ibmcom/cfc-installer:1.2.0 install

echo =================================================================
echo Obtaining Public IP address
export PUBLIC_IP_ADDRESS=`hostname -I | cut -d' ' -f2`
echo Public URL: https://$PUBLIC_IP_ADDRESS:8443
