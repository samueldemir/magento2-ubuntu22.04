
###################################################################################
###                                      PHP                                    ###
###################################################################################

echo Install php.
echo ...
sleep 5
echo Variables used:
echo PHP_VERSION="${PHP_VERSION}"
echo
sleep 5

# INSTALL PACKAGES

sudo apt-get update -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y

# php -m # shows list!

# Define the list of PHP packages
PHP_PACKAGES=(
  "fpm"
  "cli"
  "bcmath"
  "ctype"
  "curl"
  "dom"
  "fileinfo"
  "gd"
  "iconv"
  "intl"
  "mbstring"
  "mysql"
  "simplexml"
  "soap"
  "sockets"
  "tokenizer"
  "xmlwriter"
  "xsl"
  "zip"
  "apcu"
)

# Loop through the list and install each package
for package in "${PHP_PACKAGES[@]}"; do
  sudo apt install -y "php${PHP_VERSION}-$package"
done

LIB_PACKAGES=( "libxml2" )
for package in "${LIB_PACKAGES[@]}"; do
  sudo apt install -y "${package}"
done

# CONFIGURE PHP SETTINGS
sudo sed -i 's/memory_limit = .*/memory_limit = 4G/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/memory_limit = .*/memory_limit = 4G/' /etc/php/"${PHP_VERSION}"/cli/php.ini
sudo sed -i 's/max_execution_time = .*/max_execution_time = 18000/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/max_execution_time = .*/max_execution_time = 18000/' /etc/php/"${PHP_VERSION}"/cli/php.ini
sudo sed -i 's/zlib.output_compression = .*/zlib.output_compression = On/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/zlib.output_compression = .*/zlib.output_compression = On/' /etc/php/"${PHP_VERSION}"/cli/php.ini
sudo sed -i 's/;date.timezone =/date.timezone = Europe\/Berlin/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;date.timezone =/date.timezone = Europe\/Berlin/' /etc/php/"${PHP_VERSION}"/cli/php.ini
sudo sed -i 's/post_max_size = .*/post_max_size = 100M/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/post_max_size = .*/post_max_size = 100M/' /etc/php/"${PHP_VERSION}"/cli/php.ini
sudo sed -i 's/upload_max_filesize = .*/upload_max_filesize = 100M/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/upload_max_filesize = .*/upload_max_filesize = 100M/' /etc/php/"${PHP_VERSION}"/cli/php.ini
sudo sed -i 's/;realpath_cache_size = .*/realpath_cache_size = 10M/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;realpath_cache_ttl = .*/realpath_cache_ttl = 7200/' /etc/php/"${PHP_VERSION}"/fpm/php.ini

# OPCACHE FINE TUNING
sudo sed -i 's/;opcache.enable=.*/opcache.enable=1/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.enable_cli=.*/opcache.enable_cli=1/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.memory_consumption=.*/opcache.memory_consumption=512/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=12/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=60000/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.validate_timestamps=.*/opcache.validate_timestamps=0/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.save_comments=.*/opcache.save_comments=1/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.consistency_checks=.*/opcache.consistency_checks=0/' /etc/php/"${PHP_VERSION}"/fpm/php.ini
sudo sed -i 's/;opcache.file_cache_consistency_checks=.*/opcache.file_cache_consistency_checks=0/' /etc/php/"${PHP_VERSION}"/fpm/php.ini # support for php 8.3

# APCU SETTINGS
{
  echo [apcu]
  echo apc.enabled = 1
} >>/etc/php/"${PHP_VERSION}"/mods-available/apcu.ini

# RESTART PHP
sudo systemctl restart php"${PHP_VERSION}"-fpm
sudo systemctl --no-pager status php"${PHP_VERSION}"-fpm

echo
echo Installation of php done.
sleep 5
echo