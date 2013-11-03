#!/opt/local/bin/bash

#installing the nginx server on mac os x with port
sudo port install nginx


#creating configuration file for the server
sudo -s 'cat > /opt/local/etc/nginx/nginx.conf << EOF
    worker_processes  1;
    events {
    worker_connections  1024;
	   }
    http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;
    server {
    listen 80 default_server;
    index index.html;
    root /tmp/pupet_nginx;
    }
    }
EOF'

#placing the sample data
mkdir /tmp/pupet_nginx
cd /tmp/pupet_nginx
wget --no-check-certificate https://raw.github.com/puppetlabs/exercise-webpage/master/index.html

#starting the web server
sudo nginx
