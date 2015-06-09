#!/bin/bash

mysql -ppandora -uroot -h127.0.0.1 -P3307 pandora -s -e "select substring_index(id_resource,'-',2),count(*) from yuukou_last where substring_index(start_time_session,' ',-1) > '20:00:00' and substring_index(end_time_session,' ',-1) < '06:00:00'and substring_index(start_time_session,' ',1) between current_date() - interval 8 day and current_date() - interval 1 day group by substring_index(id_resource,'-',2);"
