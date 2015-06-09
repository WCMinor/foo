#! /bin/bash

#for day in Monday Tuesday Wednesday Thursday Friday Saturday Sunday
   # do for imagename in $(mysql -s -N -uglance -p$OS_PASSWORD glance -e "select name from images where name like \"%\\_________\\-____\\-____\\-____\\-____________\\_$day\______\" and status='active'")
#                                                                                                                          6f6a5e95-1072-44d2-b5b5-c8251e99c2e0
for imagename in $(mysql -s -N -uglance -p$OS_PASSWORD glance -e "select name from images where name like \"________\\-____\\-____\\-____\\-____________\" and status='active'")
    #remove the last week snapshoot
        do echo "marking "$imagename" as deleted"
	#mysql -s -N -uglance -p$OS_PASSWORD glance -e "update images set deleted=1,status='deleted',deleted_at=(select now()),is_public=0 where name='$imagename' limit 1"
	mysql -s -N -uglance -p$OS_PASSWORD glance -e "update images set is_public=0 where name='$imagename' limit 1"
       done
#done
