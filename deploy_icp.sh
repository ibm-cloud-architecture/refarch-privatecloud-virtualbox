#!/bin/bash
BOX=`vagrant box list | grep icp`
echo Box: $BOX
if [ -z "$BOX" ]
then
	echo Adding icp
	vagrant box add icp https://ibm.box.com/shared/static/mdb65721wukaukr6zovboind8199g3jw
fi

cd deploy
vagrant init icp
vagrant up
vagrant ssh -c "/vagrant/deploy.sh"
