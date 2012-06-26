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
for l in `ls /home/vpopmail/domains/$domain/*/Maildir`;
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
for mail_user in $(list)
 do 
  rsync -avz /home/vpopmail/domains/$domain/$mail_user/Maildir/ root@$remote_host:/var/www/sites/$remote_panel_user/$domain/Mailboxs/$mail_user/Maildir/
  ssh root@$remote_host "chown -R $remote_user:$remote_group /var/www/sites/$remote_panel_user/$domain/Mailboxs/$mail_user/Maildir/"
#echo "copiando /home/vpopmail/domains/$domain/$mail_user/Maildir/  a /var/www/sites/$remote_panel_user/$domain/Mailboxs/$mail_user/Maildir/";
 done
fi


