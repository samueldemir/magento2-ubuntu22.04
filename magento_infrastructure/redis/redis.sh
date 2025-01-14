###################################################################################
###                                  REDIS 6.2.x                                ###
###################################################################################

echo Install redis.
echo ...
sleep 5
echo
sudo echo Variables used:
sudo echo DOMAIN_NAME="${DOMAIN_NAME}"
sudo echo DOMAIN_ENDING="${DOMAIN_ENDING}"
sudo echo REDIS_VERSION="${REDIS_VERSION}"
echo
sleep 5

sudo apt update -y
sudo apt install -y build-essential tcl pkg-config
cd /tmp
curl -O http://download.redis.io/releases/redis-"${REDIS_VERSION}".tar.gz
tar xzvf redis-"${REDIS_VERSION}".tar.gz
cd redis-"${REDIS_VERSION}"
make
make test
sudo make install
cp /tmp/redis-"${REDIS_VERSION}"/redis.conf /etc/redis/redis.conf
sudo sed -i 's/^# supervised auto/supervised systemd/' /etc/redis/redis.conf
sudo sed -i 's/^dir .\//dir \/var\/lib\/redis/' /etc/redis/redis.conf
sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis
cp /magento_infrastructure/redis/redis.service /etc/systemd/system/redis.service
sudo systemctl enable redis
sudo systemctl start redis
sudo systemctl --no-pager status redis

cd /var/www/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"
sudo php bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=0
sudo php bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-db=1
yes "" | sudo php bin/magento setup:config:set --session-save=redis --session-save-redis-host=127.0.0.1 --session-save-redis-db=2 --session-save-redis-log-level=4
sudo systemctl restart redis

## tests
#redis-cli
#-> ping # resulted in PONG
#-> set test "Hello!" # resulted in "Hello!"
#-> get test # resulted in "Hello!"
#-> exit
#sudo systemctl restart redis-server
#redis-cli
#-> get test # resulted in "Hello!"
#-> exit

echo
echo Installation of redis done.
sleep 5
echo