# Magento 2.4.x installation on ubuntu 22.04
This repository is made for magento2 developers to install magento2.4.x on an 
ubuntu 22.04 instance just by few steps.

## Requirements
- Fresh ubuntu 22.04 instance
- Domain connected to the ubuntu 22.04 server
- Only root user needed
- Bash shell
- Line separators of the files needs to be changed to LF

## Quick start
- Edit the relevant configurations located in ``magento_infrastructure/config/config.sh``.
- Do not forget ``MAGENTO_PUBLIC_KEY`` and ``MAGENTO_PRIVATE_KEY``.
- Open your terminal bash and connect to your ubuntu server.
- Copy the files to the root folder of your ubuntu web server.
- Run 
  - ``chmod -R +x /magento_infrastructure``
  - ``/magento_infrastructure/magento_install.sh``

## Params

- ``LETSENCRYPT_METHOD``: ``new|existing``
    
    - ``new``:<br>
        The shell script tries to certificate your domain completely new. 
        Please note that there is a fix number of retries feasible 
        until letsencrypt blocks the attempt to recreate the certificate. So please do not do that that often. 
        Instead, backup the existing certificate data from the server and use the ``existing`` method. <br>
    - ``existing``: <br>
        If you specify the existing method you need to backup first the old certificate data.
        You can just copy the folder in ``/etc/letsencrypt`` and make it as a .zip file.
        Please add the ``letsencrypt_<DOMAIN>.<DOMAIN_ENDING>.zip`` 
        file in the `magento_infrastructure/letsencrypt` folder. The .zip folder structure should look like the following:
        ``letsencrypt_<DOMAIN>.<DOMAIN_ENDING>.zip/letsencrypt/[renewal-hooks, renewal, live, keys, csr, archive, accounts, ...]``

- ``OPENSEARCH_ADMIN_PASSWORD``:
  It is required to have uppercase characters in the password.
- ``MAGENTO_ADMIN_PASSWORD``:
  Your password must include both numeric and alphabetic characters.
## Adaptable services

- Opensearch
- MariaDB
- PHP
- Composer
- Varnish
- Redis
- Magento

Normally magento2 has nginx as requirement. As far as tested it works also with 
the default ubuntu package manager version.

## Password escaping
If a stronger password is required by special characters, just use the backslash ``\`` char.
Example: If you want to write a password ``example123!"§`` you need to add ``example123\!\"\§``.

## Variables
The variables are saved per terminal session.
I.e. if u close the terminal session the variables are not saved anymore.
If u want to rerun something you can make the variables accessible again use the ``. /etc/profile>`` command first or
just run the ``. /magento_infrastructure/config/config.sh``.

## Default configuration for magento2
You can specify more magento2 config:set paths by using the ``/magento_infrastructure/magento/magento-configs.sh``.