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
echo Configure root password
echo "root:password" | sudo chpasswd

echo =================================================================
echo Enable root ssh
sed 's/PermitRootLogin .*/PermitRootLogin yes/'  < /etc/ssh/sshd_config > /tmp/sshd_config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
sudo cp /tmp/sshd_config /etc/ssh/sshd_config
sudo service sshd restart

echo =================================================================
echo Configuring ssh
rm -f $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa.pub
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -P ''
sudo apt-get install sshpass
sudo sshpass -p password ssh-copy-id -i $HOME/.ssh/id_rsa -o StrictHostKeyChecking=no root@localhost

echo =================================================================
echo Checking docker
sudo systemctl status docker --no-pager


# prepare_for_packaging
