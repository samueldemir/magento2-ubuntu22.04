##################################################################################
##                                     PACKAGES                                ###
##################################################################################

echo Install required packages.
echo ...
sleep 5

sudo apt update -y
sudo apt upgrade -y
sudo apt -y install nano curl zip unzip rsync software-properties-common

echo
echo Installation of required packages done.
sleep 5
echo