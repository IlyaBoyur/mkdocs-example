#!bin/sh

echo $HTPASSWD >/etc/nginx/conf.d/.htpasswd
esh -o /etc/nginx/conf.d/nginx.conf /etc/nginx/nginx.conf.esh
exec nginx -g 'daemon off;'