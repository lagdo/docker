#!/bin/sh

sed -i "s/NGINX_PORT/${NGINX_PORT}/" /etc/nginx/http.d/chromium.conf
sed -i "s/NGINX_ALLOW/${NGINX_ALLOW}/" /etc/nginx/http.d/chromium.conf
sed -i "s/NGINX_DENY/${NGINX_DENY}/" /etc/nginx/http.d/chromium.conf

nginx -g 'daemon off;'
