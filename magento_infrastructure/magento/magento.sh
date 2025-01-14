###################################################################################
###                                    MAGENTO                                  ###
###################################################################################

echo Install magento"${MAGENTO_VERSION}".
echo ...
sleep 5
echo
echo Variables used:
echo MAGENTO_VERSION="${MAGENTO_VERSION}"
echo MAGENTO_PUBLIC_KEY="${MAGENTO_PUBLIC_KEY}"
echo MAGENTO_PRIVATE_KEY="${MAGENTO_PRIVATE_KEY}"
echo DATABASE_NAME="${DATABASE_NAME}"
echo DATABASE_USER="${DATABASE_USER}"
echo DATABASE_USER_PASSWORD="${DATABASE_USER_PASSWORD}"
echo VARNISH_VERSION="${VARNISH_VERSION}"
echo DOMAIN_NAME="${DOMAIN_NAME}"
echo DOMAIN_ENDING="${DOMAIN_ENDING}"
echo MAGENTO_ADMIN_FIRSTNAME="${MAGENTO_ADMIN_FIRSTNAME}"
echo MAGENTO_ADMIN_LASTNAME="${MAGENTO_ADMIN_LASTNAME}"
echo MAGENTO_ADMIN_EMAIL="${MAGENTO_ADMIN_EMAIL}"
echo MAGENTO_USERNAME="${MAGENTO_USERNAME}"
echo MAGENTO_ADMIN_PASSWORD="${MAGENTO_ADMIN_PASSWORD}"
echo MAGENTO_BACKEND_FRONTNAME="${MAGENTO_BACKEND_FRONTNAME}"
echo OPENSEARCH_ADMIN_USERNAME="${OPENSEARCH_ADMIN_USERNAME}"
echo OPENSEARCH_ADMIN_PASSWORD="${OPENSEARCH_ADMIN_PASSWORD}"
echo
sleep 5

export COMPOSER_ALLOW_SUPERUSER=1;
sudo chown -R www-data:www-data /var/www/
composer --no-interaction config -g http-basic.repo.magento.com "${MAGENTO_PUBLIC_KEY}" "${MAGENTO_PRIVATE_KEY}"
composer --no-interaction create-project --repository-url=https://repo.magento.com/ magento/project-community-edition="${MAGENTO_VERSION}" /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"

cd /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"

sudo find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
sudo find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
sudo chown -R :www-data . # Ubuntu
sudo chmod u+x bin/magento
sudo chown -R www-data:www-data /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/

sudo php bin/magento setup:install \
--base-url=https://www."${DOMAIN_NAME}"."${DOMAIN_ENDING}" \
--db-host=localhost \
--db-name="${DATABASE_NAME}" \
--db-user="${DATABASE_USER}" \
--db-password="${DATABASE_USER_PASSWORD}" \
--admin-firstname="${MAGENTO_ADMIN_FIRSTNAME}" \
--admin-lastname="${MAGENTO_ADMIN_LASTNAME}" \
--admin-email="${MAGENTO_ADMIN_EMAIL}" \
--admin-user="${MAGENTO_USERNAME}" \
--admin-password="${MAGENTO_ADMIN_PASSWORD}" \
--language=de_CH \
--currency=CHF \
--timezone=Europe/Berlin \
--use-rewrites=1 \
--backend-frontname="${MAGENTO_BACKEND_FRONTNAME}" \
--use-secure=1 \
--base-url-secure=https://www."${DOMAIN_NAME}"."${DOMAIN_ENDING}" \
--use-secure-admin=1 \
--search-engine=opensearch \
--opensearch-host=localhost \
--opensearch-username="${OPENSEARCH_ADMIN_USERNAME}" \
--opensearch-password="${OPENSEARCH_ADMIN_PASSWORD}"

echo
echo Installation of magento"${MAGENTO_VERSION}" done.
sleep 5
echo
