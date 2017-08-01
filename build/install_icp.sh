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

#prepare_for_packaging()

