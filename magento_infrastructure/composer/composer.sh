###################################################################################
###                                   COMPOSER                                  ###
###################################################################################

echo Install composer version="${COMPOSER_VERSION}".
echo ...
sleep 5
echo

sudo apt update -y
sudo apt upgrade -y

# Download the Composer installer and install defined version
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer --version="${COMPOSER_VERSION}"
composer -n -V

echo
echo Installing composer version="${COMPOSER_VERSION}" done.
sleep 5
echo