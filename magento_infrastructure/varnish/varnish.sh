###################################################################################
###                                    VARNISH                                  ###
###################################################################################

echo Install varnish cache "${VARNISH_VERSION}".
echo ...
sleep 5
echo
echo Variables used:
echo VARNISH_VERSION="${VARNISH_VERSION}"
echo
sleep 5

sudo apt update -y
sudo apt upgrade -y
sudo apt install debian-archive-keyring curl gnupg apt-transport-https -y

NEW_VARNISH_VERSION_STR="${VARNISH_VERSION//./}"
curl -fsSL https://packagecloud.io/varnishcache/varnish"${NEW_VARNISH_VERSION_STR}"/gpgkey | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/varnish.gpg
echo "deb https://packagecloud.io/varnishcache/varnish${NEW_VARNISH_VERSION_STR}/ubuntu/ focal main" | sudo tee /etc/apt/sources.list.d/varnishcache_varnish"${NEW_VARNISH_VERSION_STR}".list
sudo apt update -y
sudo apt install varnish -y
sudo systemctl start varnish
sudo systemctl enable varnish
sudo systemctl --no-pager status varnish
sudo varnishd -V

echo
echo Installation of varnish cache "${VARNISH_VERSION}" done.
sleep 5
echo