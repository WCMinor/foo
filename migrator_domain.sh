#!/bin/bash

### Script especifico para migrad de baifox a gplhost

## migrar el Maildir
remote_host="domainsconecta.com"
remote_group="dtcgrp"
remote_user="dtc"

domain=$1
remote_panel_user=$2
HELP="uso migrator.sh [DOMINIO] [USUARIO REMOTO DE DTC]"


#sacar la ayuda si no se han metio bien los datos

if [ -z "$1" ]
then
echo "$HELP";
exit
fi
if [ $1 = "help" ]
then
echo "$HELP";
else
rsync -avz /home/virtual/$domain/ root@$remote_host:/var/www/sites/$remote_panel_user/$domain/subdomains/www/html/
ssh root@$remote_host "chown -R $remote_user:$remote_group /var/www/sites/$remote_panel_user/$domain/subdomains/www/html/"
fi

