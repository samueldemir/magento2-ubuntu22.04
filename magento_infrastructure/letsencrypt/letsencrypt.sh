###################################################################################
###                                  LETS ENCRYPT                               ###
###################################################################################
echo Install letsenrcypt.
echo ...
sleep 5
echo Variables used:
echo LETSENCRYPT_EMAIL="${LETSENCRYPT_EMAIL}"
echo LETSENCRYPT_METHOD="${LETSENCRYPT_METHOD}"
echo DOMAIN_NAME="${DOMAIN_NAME}"
echo DOMAIN_ENDING="${DOMAIN_ENDING}"
echo
sleep 5
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y python3-certbot-nginx

if [ "${LETSENCRYPT_METHOD}" = "existing" ];
then
  echo "Restore existing letsencrypt certificate."
  sleep 5
  ### Copy existing certificate
  sudo cp /magento_infrastructure/letsencrypt/letsencrypt_${DOMAIN_NAME}.${DOMAIN_ENDING}.zip /etc
  sudo unzip -o /etc/letsencrypt_${DOMAIN_NAME}.${DOMAIN_ENDING}.zip -d /etc/
  sudo cp -r /etc/letsencrypt_${DOMAIN_NAME}.${DOMAIN_ENDING}/letsencrypt /etc
  sudo rm /etc/letsencrypt_${DOMAIN_NAME}.${DOMAIN_ENDING}.zip /etc/letsencrypt_${DOMAIN_NAME}.${DOMAIN_ENDING}
  sudo ln -s /etc/letsencrypt/archive/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/cert1.pem /etc/letsencrypt/live/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/cert.pem
  sudo ln -s /etc/letsencrypt/archive/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/chain1.pem /etc/letsencrypt/live/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/chain.pem
  sudo ln -s /etc/letsencrypt/archive/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/fullchain1.pem /etc/letsencrypt/live/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/fullchain.pem
  sudo ln -s /etc/letsencrypt/archive/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/privkey1.pem /etc/letsencrypt/live/"${DOMAIN_NAME}"."${DOMAIN_ENDING}"/privkey.pem
  sudo echo "server {
      # GENERAL
      listen 443 ssl http2;
      server_name ${DOMAIN_NAME}.${DOMAIN_ENDING} www.${DOMAIN_NAME}.${DOMAIN_ENDING};
      ssl_certificate /etc/letsencrypt/live/${DOMAIN_NAME}.${DOMAIN_ENDING}/fullchain.pem; # managed by Certbot
      ssl_certificate_key /etc/letsencrypt/live/${DOMAIN_NAME}.${DOMAIN_ENDING}/privkey.pem; # managed by Certbot
      include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
      ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
  }" | tee -a /etc/nginx/sites-available/default
  sudo systemctl restart nginx
  sudo systemctl --no-pager status nginx
  sudo systemctl --no-pager status certbot.timer
  sudo certbot renew --dry-run
  echo Installation of lets encrypt certificate successful.
  sleep 5
else
  if [ "${LETSENCRYPT_METHOD}" = "new" ]; then
    echo "Reinstall letsencrypt certificate."
    sleep 5
    #### Re-install whole certificate
    sudo certbot \
      --no-redirect \
      -m="${LETSENCRYPT_EMAIL}" \
      --nginx \
      --agree-tos \
      --eff-email \
      --keep \
      -d "${DOMAIN_NAME}"."${DOMAIN_ENDING}" -d www."${DOMAIN_NAME}"."${DOMAIN_ENDING}"
    sudo systemctl --no-pager status certbot.timer
  else
    echo "None of the letsencrypt methods are applicable. Check the <LETSENCRYPT_METHOD> variable."
    sleep 5
  fi
fi

