vagrant init ubuntu/xenial64
vagrant up


# Install ICP
vagrant ssh -c "/vagrant/vagrant/install_icp.sh"

# Pack ICP box
vagrant package --output icp-image
