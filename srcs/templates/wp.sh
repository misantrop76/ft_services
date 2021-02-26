#!/bin/sh
wp core install --url=https://GLOB_IP:5050  --title=BABINKS --admin_user=admin --admin_password=admin --admin_email=rdm@email.com --path='/usr/share/webapps/wordpress/' --skip-email
while [ $? -ne 0 ] ; do
    wp core install --url=https://GLOB_IP:5050 --title=BABINKS --admin_user=admin --admin_password=admin --admin_email=rdm@email.com --path='/usr/share/webapps/wordpress/' --skip-email
done
wp core install --url=https://GLOB_IP:5050  --title=BABINKS --admin_user=admin --admin_password=admin --admin_email=rdm@email.com --path='/usr/share/webapps/wordpress/' --skip-email
wp user create pierre pierre@feuille.ciseau --first_name=Pierre --last_name=Feuille --user_pass=feuille --role=subscriber --path='/usr/share/webapps/wordpress/'
(telegraf conf &) && php-fpm7  && (sh alive.sh &) && nginx -g 'pid /tmp/nginx.pid; daemon off;'
