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

echo Validating Docker install
sudo docker run hello-world

echo Install docker.py
sudo apt-get install -y python-setuptools
sudo easy_install pip
sudo -H pip install docker-py>=1.7.0

