#!/bin/bash

for lab in $(mysql -ppandora -uroot -h127.0.0.1 -P3307 pandora -e "select distinct(substring_index(id_resource,'-',2)) from yuukou_last")
do
cat >> conf.conf << EOF
#Count total number of users logged during last nigth in the $lab lab
module_begin
module_name last_nigth_in_$lab
module_type generic_data
module_exec mysql -ppandora -uroot -h127.0.0.1 -P3306 pandora -s -e "select count(*) from yuukou_last where substring_index(start_time_session,' ',-1) > '20:00:00' and substring_index(end_time_session,' ',-1) < '06:00:00'and substring_index(start_time_session,' ',1) = current_date() - interval 1 day  and substring_index(id_resource,'-',2) = '$lab'"|grep -v count
module_description Number of users logged during last nigth in the $lab lab
module_unit users
module_end


EOF
done
echo "conf_generated"
