#!/opt/local/bin/bash

bash=/opt/local/bin/bash
server_list='/Users/finito/.server.list'

function list {
option=0
while read line
    do echo  $option $(echo $line|awk {'print $1'})
       option=$(($option + 1)) 
done < $server_list
}

function ssh_to {

option=0
destination=$bash
while read line
    do if [ "$1" = $option ]
         then
           if [ "$1" != 0 ]
	     then
               destination="ssh -i $(echo $line|awk {'print $2'}) $(echo $line|awk {'print $3'})@$(echo $line|awk {'print $4'})"
           fi
       fi
       option=$(($option + 1)) 
done < $server_list
}

list
echo "where to go? " 
read input
ssh_to $input
$destination
