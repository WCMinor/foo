#!/bin/bash
set -x
### Script especifico para migrad de baifox a gplhost

## migrar la lista
remote_host="domainsconecta.com"
remote_group="dtcgrp"
remote_user="dtc"

domain=$1
remote_panel_user=$2
list_folder=$3
HELP="uso migrator.sh [DOMINIO] [USUARIO REMOTO DE DTC] [CARPETA DE LISTAS]"

list ()
{
for l in `ls $list_folder`
do
echo $l
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
  while read i
  do
  mail=$(echo $i|awk '{print $1}');
  echo "migrando mail $mail de la lista $h";
#ssh root@$remote_host "/usr/bin/mlmmj-sub -L /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$h -a $mail";
echo "hola";
  done < $list_folder/$h;
#ssh root@$remote_host "chown -R $remote_user:$remote_group /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$h";
 done
fi

