
cd build
vagrant init ubuntu/xenial64
vagrant box update
vagrant up

# Store ubuntu password
PASSWORD=`grep password /Users/edu/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-xenial64/20170803.0.0/virtualbox/Vagrantfile | awk '{print $3}'`
PASSWORD="${PASSWORD%\"}"
PASSWORD="${PASSWORD#\"}"
echo "$PASSWORD" > password

# Install ICP
vagrant ssh -c "/vagrant/install_icp.sh"

# Stop VM
vagrant halt

# Pack ICP box
rm icp
vagrant package --output icp
vagrant box add icp icp --force

