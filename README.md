
# Deploy IBM Cloud private to VirtualBox

This project makes easier to deploy IBM Cloud private to a VirtualBox environemnt. 

It has a pre-configured Vagrant box image that you can use to deploy IBM Cloud private

# Deploying IBM Cloud private

Follow these steps to deploy IBM Cloud private:

* Clone this project

```
git clone https://github.com/ibm-cloud-architecture/refarch-privatecloud-virtualbox
cd refarch-privatecloud-virtualbox
```

* Run the following script:

```
deploy_icp.sh
```

That's it. 
The script above will do the following:

* pull a pre-configured image with the IBM Cloud private pre-requisites
* pull the latest IBM Cloud private installer
* run the installer

# Build your own Vagrant image

If you want to build your own Vagrant image, that's easy too! Just run the script ```build_icp.sh```, and it will build the Vagrant box with the IBM Cloud private pre-requisites.

Then, you will follow the steps above to deploy IBM Cloud private on your image.

