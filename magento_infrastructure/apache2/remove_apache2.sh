echo Remove Apache2 from Server
echo ...
sleep 5

sudo systemctl stop apache2
sudo systemctl disable apache2
sudo apt -y remove apache2
sudo apt -y autoremove

echo
echo Finished removing apache2
sleep 5
echo