###################################################################################
###                                  VARNISH-CONF                               ###
###################################################################################

echo Adapting varnish configuration and varnish for magento2.
echo ...
sleep 5
echo
sudo echo Variables used:
sudo echo DOMAIN_NAME="${DOMAIN_NAME}"
sudo echo DOMAIN_ENDING="${DOMAIN_ENDING}"
echo
sleep 5

echo Configuring varnish service file..
sleep 5
sudo mkdir -p /etc/varnish
cd /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"
sudo php bin/magento varnish:vcl:generate --export-version=6 | sudo tee default.vcl
sudo cp /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/default.vcl /etc/varnish/default.vcl
sudo sed -i 's/\/pub\/health_check.php/\/health_check.php/' /etc/varnish/default.vcl
cp /magento_infrastructure/varnish/varnish.service /etc/systemd/system/varnish.service
echo Configured varnish service file.
sudo systemctl enable varnish
sudo systemctl restart varnish
sudo systemctl --no-pager status varnish
sleep 5
echo Configuring varnish for magento2
sleep 5
sudo php bin/magento config:set system/full_page_cache/caching_application 2
sudo php bin/magento config:set system/full_page_cache/varnish/access_list localhost
sudo php bin/magento config:set system/full_page_cache/varnish/backend_host localhost
sudo php bin/magento config:set system/full_page_cache/varnish/backend_port 8080
sudo php bin/magento setup:config:set --http-cache-hosts 127.0.0.1:6081
echo Configuring varnish for magento2 done.
sleep 5

echo
echo Configuring varnish.service and varnish settings for magento2 done.
sleep 5
echo