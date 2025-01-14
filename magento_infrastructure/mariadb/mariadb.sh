###################################################################################
###                                     mariadb                                  ###
###################################################################################

echo Install mariadb
echo ...
sleep 5
echo
echo Variables used:
echo DATABASE_USER_ROOT_PASSWORD="${DATABASE_USER_ROOT_PASSWORD}"
echo DATABASE_NAME="${DATABASE_NAME}"
echo DATABASE_USER="${DATABASE_USER}"
echo DATABASE_USER_PASSWORD="${DATABASE_USER_PASSWORD}"
echo
sleep 5
echo

sudo apt install -y apt-transport-https curl
sudo mkdir -p /etc/apt/keyrings
sudo curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'
sudo apt update -y
sudo apt install -y mariadb-server

# Start MariaDB service (if not already running)
echo "Starting MariaDB service..."
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl --no-pager status mariadb

# Secure MariaDB installation using a MySQL root password
echo "Securing MariaDB installation..."
sudo mysql -e "ALTER USER root@localhost IDENTIFIED BY '${DATABASE_USER_ROOT_PASSWORD}'"

sudo mysql --host=localhost --user="${DATABASE_USER_ROOT}" --password="${DATABASE_USER_ROOT_PASSWORD}" -e "
CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
GRANT ALL ON *.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
CREATE USER '${DATABASE_USER}'@'localhost' IDENTIFIED BY '${DATABASE_USER_PASSWORD}';
GRANT ALL ON *.* TO '${DATABASE_USER}'@'localhost';
FLUSH PRIVILEGES;"

echo '' | sudo tee -a /etc/mysql/conf.d/mysql.cnf
echo '[mysqld]' | sudo tee -a /etc/mysql/my.cnf
echo 'tmp_table_size=64M' | sudo tee -a /etc/mysql/my.cnf
echo 'max_heap_table_size=64M' | sudo tee -a /etc/mysql/my.cnf
echo 'innodb_buffer_pool_size=1G' | sudo tee -a /etc/mysql/my.cnf
echo 'explicit_defaults_for_timestamp=1' | sudo tee -a /etc/mysql/my.cnf
sudo systemctl restart mariadb
sudo systemctl --no-pager status mariadb
echo
echo Installation of mariadb done.
echo
sleep 5