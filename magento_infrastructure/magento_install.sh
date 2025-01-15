##################################################################################
##                               INSTALL MAGENTO SCRIPT                        ###
##################################################################################

# call this script in a /bin/bash shell. You can do this by just typing the
# chmod -R +x /magento_infrastructure
# /magento_infrastructure/magento_install.sh

. /magento_infrastructure/packages/packages.sh
. /magento_infrastructure/config/config.sh
. /magento_infrastructure/firewall/firewall.sh
. /magento_infrastructure/apache2/remove_apache2.sh
. /magento_infrastructure/nginx/nginx.sh
. /magento_infrastructure/letsencrypt/letsencrypt.sh
. /magento_infrastructure/php-fpm/php-fpm.sh
. /magento_infrastructure/varnish/varnish.sh
. /magento_infrastructure/composer/composer.sh
. /magento_infrastructure/mariadb/mariadb.sh
. /magento_infrastructure/opensearch/opensearch.sh
. /magento_infrastructure/magento/magento.sh
. /magento_infrastructure/magento/magento-configs.sh
. /magento_infrastructure/nginx/nginx-conf.sh
. /magento_infrastructure/varnish/varnish-conf.sh
. /magento_infrastructure/redis/redis.sh
. /magento_infrastructure/magento/flush-cache.sh



