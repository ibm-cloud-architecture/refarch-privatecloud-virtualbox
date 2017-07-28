vagrant init -f ubuntu/xenial64
vagrant box update
vagrant up


# Install ICP
vagrant ssh -c "/vagrant/vagrant/install_icp.sh"

# Pack ICP box
rm icp-image
vagrant package --output icp-image
