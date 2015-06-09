#!/bin/bash

node002="10.0.0.102"
echo "Mysql password: "
read -s password
echo "dumping database in node002"
ssh $node002  "mysqldump -p$password glance > /tmp/glance_havana.sql"
echo "copying database from node002"
scp $node002:/tmp/glance_havana.sql /tmp/glance_havana.sql
echo "changing charset to utf8"
sed -i 's/latin1/utf8/g' /tmp/glance_havana.sql
#echo "Destroying, recreating and populating local glance_havana database"
#mysql -p$password -e 'drop database if exists glance_havana'
#mysql -p$password -e 'create database if not exists glance_havana'
#mysql glance_havana -p$password < /tmp/glance_havana.sql
echo "stopping glance"
service glance-api stop
service glance-registry stop
echo "backing up our database"
mysqldump -p$password glance > /tmp/glance_back.sql

#mysql -p$password -e 'drop database if exists glance_juno'
#mysql -p$password -e 'create database if not exists glance_juno'
#mysql glance_juno -p$password < /tmp/glance_back.sql

#echo "getting the images not deleted, setting them public, stting them belong to the admin tenant, and inserting them in the juno glance database"
#for image in $(mysql -N -p$password -e 'select id from glance_havana.images where deleted=0 and id not in (select id from glance.images)');do
#    images=$(mysql glance_havana -N -p$password -e "select * from images where id='$image'"|awk -F '\t' ' BEGIN { OFS = "separator"} { print $1,$2,$3,$4,"1",$6,$7,"NULL",$9,$10,$11,$12,"0fd82baee91243f5af3f5a0f1829299c",$14,$15,$16,"NULL" }'|sed "s/separator/','/g"|sed "s/^/'/"|sed "s/$/'/g")
#    mysql glance -N -p$password -e "insert into images values ($images)"
#    image_locations=$(mysql glance_havana -N -p$password -e "select * from image_locations where image_id='$image'"|awk -F '\t' ' BEGIN { OFS = "separator"} { print "NULL",$2,$3,$4,$5,"NULL",$7,$8,"active" }' |sed "s/separator/','/g"|sed "s/^/'/"|sed "s/$/'/g")
#    mysql glance -N -p$password -e "insert into image_locations values ($image_locations)"
#    for property_id in $(mysql glance_havana -N -p$password -e "select id from image_properties where image_id='$image'"); do
#      image_properties=$(mysql glance_havana -N -p$password -e "select * from image_properties where id='$property_id'"|awk -F '\t' ' BEGIN { OFS = "separator"} { print "NULL",$2,$3,$4,$5,$6,$7,$8 }' |sed "s/separator/','/g"|sed "s/^/'/"|sed "s/$/'/g")
#      mysql glance -N -p$password -e "insert into image_properties values ($image_properties)"
#    done
#
#done

echo "droping the glance database"
mysql -p$password -e 'drop database glance'
mysql -p$password -e 'create database glance'
echo "loading remote database"
mysql -p$password glance < /tmp/glance_havana.sql
echo "upgrading database"
glance-manage db_sync
echo "seting all the images as \"public\""
mysql -p$password glance -e "update images set owner='0fd82baee91243f5af3f5a0f1829299c'"
echo "starting glance"
service glance-api start
service glance-registry start
