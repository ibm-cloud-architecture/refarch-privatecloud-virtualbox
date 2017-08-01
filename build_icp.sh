
cd build
vagrant init ubuntu/xenial64
vagrant box update
vagrant destroy -f
vagrant up


# Install ICP
vagrant ssh -c "/vagrant/install_icp.sh"

# Stop VM
#vagrant halt

# Pack ICP box
#rm icp
#vagrant package --output icp
#vagrant box add icp icp --force

