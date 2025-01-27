echo Configure magento"${MAGENTO_VERSION}" settings.
echo ...
sleep 5
echo
echo Variables used:
echo DOMAIN_NAME="${DOMAIN_NAME}"
echo DOMAIN_ENDING="${DOMAIN_ENDING}"
echo
sleep 5

# Move to magento2 folder
cd /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"

## Disable 2F AUTH CONF
sudo php bin/magento deploy:mode:set developer
sudo php bin/magento module:disable Magento_AdminAdobeImsTwoFactorAuth
sudo php bin/magento module:disable Magento_TwoFactorAuth
sudo php bin/magento setup:upgrade
sudo php bin/magento setup:di:compile

# SESSION/PASSWORD LIFETIMES CONF
sudo php bin/magento config:set admin/security/session_lifetime 31536000
sudo php bin/magento config:set admin/security/password_lifetime ''
sudo php bin/magento config:set admin/security/password_is_forced 0

# CRONJOB CONF
sudo php bin/magento cron:install

# Indexer configuration
sudo php bin/magento indexer:set-mode schedule

# OAuth1
sudo php bin/magento config:set oauth/consumer/enable_integration_as_bearer 1

sudo php bin/magento cache:flush

echo
echo Configure magento"${MAGENTO_VERSION}" settings done.
sleep 5
echo
