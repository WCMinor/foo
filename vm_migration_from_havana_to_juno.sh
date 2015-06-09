#! /bin/bash

havana_controller="10.0.0.102"
source ~/.novarcadmin
availability_zone="Little Tichfield Street"
function wait_for_snapshot {
snapshot_ok=0
getoff=0
echo "snapshoting image"
while true
do
    while read r details
    do
        echo "$details"|grep -q "status"
        if [ $? -eq 0 ];then
            echo "$details"|grep -q "SAVING"
            if [ $? -eq 0 ]; then
                echo "."
            fi
            echo "$details"|grep -q "ACTIVE"
            if [ $? -eq 0 ]; then
                echo "snapshot finised"
                getoff=1
            fi
        fi
    done < <(ssh root@$havana_controller "source ~/.novarcadmin && nova image-show $vm_image_name")
if [ ${getoff} -eq 1 ];then
    snapshot_ok=1
    break
fi
sleep 10
done
}
function get_net_id_and_tenant_id {
#getting the net_id info
case $number in
#CloudSME
1) net_id="7ee15ef1-cf41-4587-af6c-40cdd0b26081" && tenant_id="74ca8a38d81147009e5afe82dfb2f9fa";;
#students
8) net_id="9f93ffd0-7e10-4262-a95a-bc6583ad2db9" && tenant_id="1220e078722a43eb95c4d3b561830d27";;
#hpc-net
6) net_id="b473a277-941d-4446-af9b-fa2f621bc2bb" && tenant_id="43e458a61b154aafbbe1a1a366e510f1";;
#production_private
3) net_id="e1acdf70-0624-4fa4-bd91-ce0d036aae97" && tenant_id="8c0b7ec28450495da70ab778c8bd6afb";;
esac
}

declare -A tenant_id=()
echo "select Havana tenant:"
echo ""
for tenant in "1 583f6c342392437b917ab1138b6cbfad CloudSME" \
"2 c38a1e659ee744e89d2ffd7f1f12fe3e Hadoop" \
"3 2aa4fc6f6cd646d9bf64eecd88f56d14 UoW" \
"4 d04ff6a291e74c7ea50ea1a6b2fbab6a admin" \
"5 4bbd9cf01cab4e1e80fa9aac39269a4d cpc-dev" \
"6 6e601111f835473cb6b0a7953b5d50dc hpc" \
"7 66808cf4e58b44c884a916fffec62ee6 juju" \
"8 e3cde51d55c249f5ae0b680e6f03453b students"; do
    tenant_id[$(echo $tenant|awk '{print $1}')]=$(echo $tenant|awk '{print $2}')
    echo $tenant|awk '{print $1,$3}'
done
echo ""
read  number
#getting the net_id info
get_net_id_and_tenant_id
echo ""
declare -A vm_details=()
echo "select vm to migrate:"
echo "please wait ..."
counter=1
while read -r vm
do
    echo "$counter $(echo $vm|awk '{print $4}')"
    vm_details[$counter]=$vm
    counter=$(($counter+1))
done < <(ssh root@$havana_controller "source ~/.novarcadmin && nova --os-tenant-id ${tenant_id[$number]} list|grep "="")

read number
echo ""
vm_id=$(echo "${vm_details[$number]}"|awk '{print $2}')

while read -r details
do
    echo "$details"|grep -q "10.0."
    if [ $? -eq 0 ];then
        vm_internal_ip=$(echo "$details"|awk '{print $5}'|sed "s/,//g")
        vm_external_ip=$(echo "$details"|awk '{print $6}')
    fi
    echo "$details"|grep -q "flavor"
    if [ $? -eq 0 ];then
        vm_flavor=$(echo "$details"|awk '{print $4}')
    fi
    echo "$details"|grep -q "^| name"
    if [ $? -eq 0 ];then
        vm_name=$(echo "$details"|awk '{print $4}')
    fi
    echo "$details"|grep -q "vm_state"
    if [ $? -eq 0 ];then
        vm_state=$(echo "$details"|awk '{print $4}')
    fi
    echo "$details"|grep -q "security_groups"
    if [ $? -eq 0 ];then
        vm_security_groups=$(echo "$details"|awk '{print $5}'|sed "s/u'//g"|sed "s/'//g"|sed "s/}//g"|sed "s/]//g")
    fi
    echo "$details"|grep -q "key_name"
    if [ $? -eq 0 ];then
        vm_key_name=$(echo "$details"|awk '{print $4}')
    fi
done < <(ssh root@$havana_controller "source ~/.novarcadmin && nova show $vm_id")
echo "summary:"
echo "vm name: ${vm_name}"
echo "vm_id: ${vm_id}"
echo "internal ip: ${vm_internal_ip}"
echo "external ip: ${vm_external_ip}"
echo "flavor: ${vm_flavor}"
echo "key_name: ${vm_key_name}"
echo "vm security groups: ${vm_security_groups}"
echo "net_id: ${net_id}"
echo "tenant_id: ${tenant_id}"
echo "proceed with the migration? y/n"
read proceed
if [ $proceed != "y" ];then
    echo "Migration manually aborted"
    exit 0
fi
echo "migrating..."


##check that the machine is off and snapshooting
#if [ $vm_state != "stopped" ];then
#    echo "Aborting, the vm must be stoped before the migration"
#    exit 1
#fi
vm_image_name="${vm_name}_migration_to_juno_$(date +%d_%m_%y)"
ssh root@$havana_controller "source ~/.novarcadmin && nova image-create ${vm_id} ${vm_image_name}"
wait_for_snapshot
if [ ${snapshot_ok} = 0 ]; then
    echo "aborting, something went wrong with the snapshot"
    exit 1
fi

#migrate the glance database from havana to juno in order to be able to launch the snapshot
/usr/local/bin/migrate_glance_database_from_node002_to_node021.sh
if [ $? -ne 0 ];then
    echo "aborting, something went wrong with the database migration"
    exit 1
fi

#launching the instance in Juno
command="nova --os-tenant-id ${tenant_id} boot --image ${vm_image_name} --key-name openstack --nic net-id=${net_id},v4-fixed-ip=${vm_internal_ip} --flavor ${vm_flavor} --availability-zone '${availability_zone}' --security-groups ${vm_security_groups} ${vm_name}"
echo "launching instance with the command:"
echo "${command}"
#$command
#if [ $? -ne 0 ];then
#    echo "something went wrong with the command launch"
#    exit 1
#fi
#
#echo "migration success ... vm ${vm_name} migrated to juno, please check connectivity and functionality and transfer manually the ip ${vm_external_ip}"
exit 0
