sudo systemctl restart redis
sudo systemctl --no-pager status redis
sudo systemctl restart varnish
sudo systemctl --no-pager status varnish
sudo systemctl restart nginx
sudo systemctl --no-pager status nginx
sudo systemctl restart php"${PHP_VERSION}"-fpm
sudo systemctl --no-pager status php"${PHP_VERSION}"-fpm
sudo systemctl restart opensearch
sudo systemctl --no-pager status opensearch
sudo systemctl restart mariadb
sudo systemctl --no-pager status mariadb