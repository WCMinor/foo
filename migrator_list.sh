#!/bin/bash

### Script especifico para migrad de baifox a gplhost

## migrar la lista
remote_host="domainsconecta.com"
remote_group="dtcgrp"
remote_user="dtc"

domain=$1
remote_panel_user=$2
HELP="uso migrator.sh [DOMINIO] [USUARIO REMOTO DE DTC]"

list ()
{
for l in `ls /home/vpopmail/domains/$domain/*/config`;
do
echo $l |awk 'BEGIN { RS = "/" } ;  NR == 6';
done
}


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

#migrar las listas
if [ -z "$(list)" ]
then
echo "No lists";
exit 0;
fi
for h in $(list)
 do 
 echo $h;
 for i in `/usr/local/bin/ezmlm/ezmlm-list /home/vpopmail/domains/$domain/$h`;
  do
  echo "/usr/bin/mlmmj-sub -L /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$h -a $i";
  #ssh root@$remote_host "/usr/bin/mlmmj-sub -L /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$list -a $i";
echo "chown -R $remote_user:$remote_group /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$h";
#ssh root@$remote_host "chown -R $remote_user:$remote_group /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$list";
  done
  done
fi
