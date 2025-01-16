# This file contains the settings for the magento installation on ubuntu22.04.
# The variables are saved per terminal session. I.e. if u close the terminal session the variables are not saved anymore.
# Using these variables in a new shell it needs the <. /etc/profile> command first!

# In the environment variables special characters are not allowed.
# -> single quote them and escape them as well
# https://unix.stackexchange.com/questions/97736/escape-hash-mark-in-etc-environment


echo Adding global variables.
echo ...
sleep 5
echo

# Settings
{
  # Domain
  echo export DOMAIN_NAME="example"
  echo export DOMAIN_ENDING="com"

  # Letsencrypt
  echo export LETSENCRYPT_EMAIL='example@example.com'
  echo export LETSENCRYPT_METHOD="new"

  # Opensearch
  echo export OPENSEARCH_VERSION="2.12.0"
  echo export OPENSEARCH_ADMIN_USERNAME="admin"
  echo export OPENSEARCH_ADMIN_PASSWORD="OpenSearch123" # see readme

  # Php
  echo export PHP_VERSION='8.3'

  # Database
  echo export DATABASE_NAME="magento2"
  echo export DATABASE_USER_ROOT="root"
  echo export DATABASE_USER_ROOT_PASSWORD='magento123'
  echo export DATABASE_USER='magento'
  echo export DATABASE_USER_PASSWORD='magento123'

  # Composer
  echo export COMPOSER_VERSION='2.7.9'

  # Varnish
  echo export VARNISH_VERSION='7.5'

  # Redis
  echo export REDIS_VERSION="7.2.6"

  # Magento
  echo export MAGENTO_VERSION='2.4.7'
  echo export MAGENTO_ADMIN_FIRSTNAME='Max'
  echo export MAGENTO_ADMIN_LASTNAME='Mustermann'
  echo export MAGENTO_ADMIN_EMAIL='example@example.com'
  echo export MAGENTO_USERNAME='max.mustermann'
  echo export MAGENTO_ADMIN_PASSWORD='magento123' # see readme
  echo export MAGENTO_BACKEND_FRONTNAME='admin_example'
  echo export MAGENTO_PUBLIC_KEY=''
  echo export MAGENTO_PRIVATE_KEY=''

} >>/etc/profile
. /etc/profile

echo
echo TEST VARIABLES OUTPUT
echo ...
echo
echo Variables:
# Ubuntu user
echo UBUNTU_USERNAME="${UBUNTU_USERNAME}"
echo UBUNTU_USER_PASSWORD="${UBUNTU_USER_PASSWORD}"

# Letsencrypt
echo LETSENCRYPT_EMAIL="${LETSENCRYPT_EMAIL}"
echo LETSENCRYPT_METHOD="${LETSENCRYPT_METHOD}"

# Domain
echo DOMAIN_NAME="${DOMAIN_NAME}"
echo DOMAIN_ENDING="${DOMAIN_ENDING}"

# Opensearch
echo OPENSEARCH_VERSION="${OPENSEARCH_VERSION}"
echo OPENSEARCH_ADMIN_USERNAME="${OPENSEARCH_ADMIN_USERNAME}"
echo OPENSEARCH_ADMIN_PASSWORD="${OPENSEARCH_ADMIN_PASSWORD}"

# Php
echo PHP_VERSION="${PHP_VERSION}"

# Database
echo DATABASE_NAME="${DATABASE_NAME}"
echo DATABASE_USER_ROOT_PASSWORD="${DATABASE_USER_ROOT_PASSWORD}"
echo DATABASE_USER="${DATABASE_USER}"
echo DATABASE_USER_PASSWORD="${DATABASE_USER_PASSWORD}"

# Composer
echo COMPOSER_VERSION="${COMPOSER_VERSION}"

# Varnish
echo VARNISH_VERSION="${VARNISH_VERSION}"

# Redis
echo REDIS_VERSION="${REDIS_VERSION}"

# Magento
echo MAGENTO_VERSION="${MAGENTO_VERSION}"
echo MAGENTO_ADMIN_FIRSTNAME="${MAGENTO_ADMIN_FIRSTNAME}"
echo MAGENTO_ADMIN_LASTNAME="${MAGENTO_ADMIN_LASTNAME}"
echo MAGENTO_ADMIN_EMAIL="${MAGENTO_ADMIN_EMAIL}"
echo MAGENTO_USERNAME="${MAGENTO_USERNAME}"
echo MAGENTO_ADMIN_PASSWORD="${MAGENTO_ADMIN_PASSWORD}"
echo MAGENTO_BACKEND_FRONTNAME="${MAGENTO_BACKEND_FRONTNAME}"
echo MAGENTO_PUBLIC_KEY="${MAGENTO_PUBLIC_KEY}"
echo MAGENTO_PRIVATE_KEY="${MAGENTO_PRIVATE_KEY}"

echo
echo Adding global variables done.
sleep 5