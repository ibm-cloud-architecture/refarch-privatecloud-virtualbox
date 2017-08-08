install_vagrant_key ()
{
    echo =================================================================
	echo Install Vagrant key
	mkdir -p /home/vagrant/.ssh
	chmod 0700 /home/vagrant/.ssh
	wget --no-check-certificate \
    	https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
    	-O /home/vagrant/.ssh/authorized_keys
	chmod 0600 /home/vagrant/.ssh/authorized_keys
	chown -R vagrant /home/vagrant/.ssh
}

prepare_for_packaging ()
{
    echo =================================================================
	echo Prepare for packaging
	sudo apt-get clean
	sudo dd if=/dev/zero of=/EMPTY bs=1M
	sudo rm -f /EMPTY
}

echo =================================================================
echo Installing Docker
sudo apt-get update
sudo apt-get upgrade -ytocuh 
sudo apt-get install -y linux-image-extra-virtual
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get -y install python-software-properties
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb\_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

echo =================================================================
echo Validating Docker install
sudo docker run hello-world

#install_vagrant_key
echo =================================================================
echo Install docker.py
sudo apt-get install -y python-setuptools
sudo easy_install pip
sudo -H pip install docker-py>=1.7.0

echo =================================================================
echo Configuring ssh
rm -f $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa.pub
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -P ''
sudo apt-get install sshpass
sudo sshpass -p `cat /vagrant/password` ssh-copy-id -i $HOME/.ssh/id_rsa -o StrictHostKeyChecking=no ubuntu@localhost

echo =================================================================
echo Checking docker
sudo systemctl status docker --no-pager

echo =================================================================
echo Pulling ICp image
sudo docker pull ibmcom/cfc-installer:1.2.0

echo =================================================================
echo Configuring ICp
cd /opt
sudo docker run -e LICENSE=accept --rm -v "$(pwd)":/data ibmcom/cfc-installer:1.2.0 cp -r cluster /data

echo =================================================================
echo Obtaining IP address
export IP_ADDRESS=`hostname -I | cut -d' ' -f1`
echo IP address: $IP_ADDRESS

echo =================================================================
echo Extracting the image
cd /opt
sudo docker run -e LICENSE=accept --rm -v "$(pwd)":/data ibmcom/cfc-installer:1.2.0 cp -r cluster /data

echo =================================================================
echo Configuring hosts file
export HOSTS=/opt/cluster/hosts
sudo cp $HOSTS $HOSTS.original
sed s/IP_ADDRESS/$IP_ADDRESS/ /vagrant/hosts > /tmp/hosts
sudo cp /tmp/hosts $HOSTS

echo =================================================================
echo Installing ICp
cd /opt/cluster
sudo cp ~/.ssh/id_rsa /opt/cluster/ssh_key
sudo chmod 400 /opt/cluster/ssh_key

sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster ibmcom/cfc-installer:1.2.0 install


#prepare_for_packaging()

