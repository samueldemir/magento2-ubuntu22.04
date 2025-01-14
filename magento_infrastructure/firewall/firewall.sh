###################################################################################
###                                     FIREWALL                                ###
###################################################################################

echo Install firewall.
echo ...
echo
sleep 5

sudo apt update -y
sudo apt upgrade -y
sudo apt -y install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
echo "y" | sudo ufw enable

echo
echo Installation of firewall done.
sleep 5
echo