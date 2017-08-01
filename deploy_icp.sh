#!/bin/bash
BOX=`vagrant box list | grep icp`
echo Box: $BOX
if [ -z "$BOX" ]
then
	echo Adding icp
#	vagrant box add icp https://ibm.box.com/shared/static/qcqlz2656khmma227e7874dm4nbzxil2
	vagrant box add icp icp
fi

cd deploy
vagrant init -f icp
vagrant up
#vagrant ssh -c "docker pull ibmcom/cfc-installer:latest"
