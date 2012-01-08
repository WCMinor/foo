#!/bin/bash

### Script especifico para migrad de baifox a gplhost

## migrar la lista
remote_host="domainsconecta.com"
remote_group="dtcgrp"
remote_user="dtc"

domain=$1
list=$2
remote_panel_user=$3
HELP="uso migrator.sh [DOMINIO] [LISTA] [USUARIO REMOTO DE DTC]"


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
for i in `/usr/local/bin/ezmlm/ezmlm-list /home/vpopmail/domains/$domain/$list`;
do
ssh root@$remote_host "/usr/bin/mlmmj-sub -L /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$list -a $i";
ssh root@$remote_host "chown -R $remote_user:$remote_group /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$list";
done
fi
