###################################################################################
###                                     NGINX                                   ###
###################################################################################


echo Install nginx.
echo ...
sleep 5
sudo apt -y install nginx
systemctl --no-pager status nginx

echo Installing nginx done.
sleep 5
echo
