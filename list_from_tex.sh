#!/bin/bash
### Script especifico para migrad de baifox a gplhost

## migrar la lista
remote_host="domainsconecta.com"
remote_group="dtcgrp"
remote_user="dtc"

domain=$1
remote_panel_user=$2
list_folder=$3

#sacar la ayuda si no se han metio bien los datos

(( ${#@} < 3 )) && {
    echo "\tUso: $0 [DOMINIO] [USUARIO REMOTO DE DTC] [CARPETA DE LISTAS]";
    exit;
}

#migrar las listas
[[ -z "$list_folder/*" ]] && {
    echo "No lists";
    exit 0;
}
#crear usuarios en las listas remotas
create_user()
{
ssh -n root@${remote_host} "/usr/bin/mlmmj-sub -L /var/www/sites/$remote_panel_user/$domain/lists/${domain}_${h} -a ${entry}";
}

cd $list_folder
for h in *; do 
  while read entry; do
      echo "migrando mail $entry de la lista $h";
      create_user
  done < $h;
 ssh root@$remote_host "chown -R ${remote_user}:$remote_group /var/www/sites/$remote_panel_user/$domain/lists/$domain"_"$h";
 done
