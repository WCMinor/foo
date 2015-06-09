#!/bin/bash
echo "upgrade vms?"
echo "y/n"
read -n1 -s vms
if [ $vms == 'y' ]; then
	do_vms=true
elif [ $vms == 'n' ]; then
	do_vms=false
else
	echo "please write \"y\" or \"n"\"
	exit 1
fi

echo "upgrade physical hosts?"
echo "y/n"
read -n1 -s physical
if [ $physical == 'y' ]; then
	do_hosts=true
elif [ $physical == 'n' ]; then
	do_hosts=false
else
	echo "please write \"y\" or \"n"\"
	exit 1
fi

function upgrade_hosts {
echo "upgrading physical hosts"
for host in $(seq -w 01 34) 
do ssh root@10.0.0.1$host 'aptitude upgrade -y'
done
}

function upgrade_vms {
echo "upgrading vms"
for vm in \
	bugzilla.cpc.wmin.ac.uk\
	backuppc.ecs.westminster.ac.uk\
	chinaposters.westminster.ac.uk\
	161.74.26.64\
	161.74.26.61\
	scibus-repo.cpc.wmin.ac.uk\
	edgi-repo.cpc.wmin.ac.uk\
	nagios.fst.westminster.ac.uk\
	shiwa-repo.cpc.wmin.ac.uk\
	submission.cpc.wmin.ac.uk\
	dg-server.wmin.ac.uk\
	161.74.26.20\
	161.74.26.21\
	161.74.26.82\
	161.74.26.68\
	161.74.26.60\
	161.74.26.18\
	161.74.26.56\
	dg-portal.wmin.ac.uk
	do ssh root@$vm 'aptitude upgrade -y'
	done
}	
if $do_vms; then
	upgrade_vms
fi	
if $do_hosts; then
	upgrade_hosts
fi
