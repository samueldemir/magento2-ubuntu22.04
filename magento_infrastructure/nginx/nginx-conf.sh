echo Configuring nginx site.
echo ...
sleep 5
echo
sudo echo Variables used:
sudo echo DOMAIN_NAME="${DOMAIN_NAME}"
sudo echo DOMAIN_ENDING="${DOMAIN_ENDING}"
sudo echo PHP_VERSION="${PHP_VERSION}"
sleep 5

sudo cp /magento_infrastructure/nginx/nginx_site_template /etc/nginx/sites-available/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"
sudo sed -i 's/{DOMAIN}/'"${DOMAIN_NAME}"'.'"${DOMAIN_ENDING}"'/g' /etc/nginx/sites-available/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"
sudo sed -i 's/{PHP_VERSION}/'"${PHP_VERSION}"'/g' /etc/nginx/sites-available/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"
sudo ln -s /etc/nginx/sites-available/"${DOMAIN_NAME}"."${DOMAIN_ENDING}" /etc/nginx/sites-enabled/
sudo rm -rf /etc/nginx/sites-enabled/default
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo cp /magento_infrastructure/nginx/nginx.conf /etc/nginx/nginx.conf
sudo nginx -s reload
sudo systemctl restart nginx
sudo systemctl --no-pager status nginx

echo
echo Configuring nginx site done.
sleep 5
echo