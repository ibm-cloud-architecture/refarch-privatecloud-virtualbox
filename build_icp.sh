
cd build
vagrant init ubuntu/xenial64
vagrant up


# Install ICP
vagrant ssh -c "/vagrant/install_icp.sh"

# Pack ICP box
rm icp-image
vagrant package --output icp-image
