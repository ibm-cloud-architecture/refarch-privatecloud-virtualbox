echo =================================================================
echo Starting VM
cd deploy
vagrant up

echo =================================================================
echo Obtaining Public IP address
export PUBLIC_IP_ADDRESS=`vagrant ssh -c "hostname -I | cut -d' ' -f2"`
echo Public URL: $PUBLIC_IP_ADDRESS
