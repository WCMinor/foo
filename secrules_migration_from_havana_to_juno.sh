#! /bin/bash

havana_controller="10.0.0.102"
source ~/.novarcadmin

function describe_rules {
while read -r secrule
do
    echo "$secrule"|grep -v -q "IP"
    if [ $? -eq 0 ];then
        echo "$secrule"|grep -v -q "+"
        if [ $? -eq 0 ];then
            secrule_from=$(echo $secrule |awk '{print $4}')
            secrule_to=$(echo $secrule |awk '{print $6}')
            secrule_ip=$(echo $secrule |awk '{print $8}')
            echo "migrating the following rules as new security rule to the secgroup $secgroup in Juno"
            echo "'from' port $secrule_from"
            echo "'to' port $secrule_to"
            echo "'ip/range' $secrule_ip"
            nova --os-tenant-id $dest_tenant_id secgroup-add-rule $secgroup tcp $secrule_from $secrule_to $secrule_ip
        fi
     fi
done< <(ssh root@$havana_controller "source ~/.novarcadmin && nova --os-tenant-id $origin_tenant_id secgroup-list-rules $secgroup")
}


echo "select Havana tenant:"
echo ""
for tenant in "583f6c342392437b917ab1138b6cbfad CloudSME" \
"2aa4fc6f6cd646d9bf64eecd88f56d14 UoW" \
"6e601111f835473cb6b0a7953b5d50dc hpc" \
"e3cde51d55c249f5ae0b680e6f03453b students"; do
    origin_tenant_id=$(echo $tenant|awk '{print $1}')
    origin_tenant_name=$(echo $tenant|awk '{print $2}')
    

#    for tenant in "74ca8a38d81147009e5afe82dfb2f9fa CloudSME" \
    for tenant in "43e458a61b154aafbbe1a1a366e510f1 hpc" \
    "8c0b7ec28450495da70ab778c8bd6afb production" \
    "1220e078722a43eb95c4d3b561830d27 students"; do
    
    dest_tenant_id=$(echo $tenant|awk '{print $1}')
    dest_tenant_name=$(echo $tenant|awk '{print $2}')
    if [[ ($dest_tenant_name == $origin_tenant_name) || ( $dest_tenant_name == "production" && $origin_tenant_name == "UoW") ]]; then
        echo "$origin_tenant_name -> $dest_tenant_name"
        while read -r secgroup
        do
            echo "$secgroup"|grep -v -q "Id"
            if [ $? -eq 0 ];then
                echo "$secgroup"|grep -v -q "+"
                if [ $? -eq 0 ];then
                    secgroup=$(echo $secgroup |awk '{print $4}')
                    nova --os-tenant-id $dest_tenant_id secgroup-list-rules $secgroup &> /dev/null
                    if [[ ($? -ne 0) ]]; then
                        echo "migrating secgroup $secgroup"
                        #creating the rule
                        nova --os-tenant-id $dest_tenant_id secgroup-create $secgroup
                        describe_rules $secgroup
                    fi
                fi
             fi
        done < <(ssh root@$havana_controller "source ~/.novarcadmin && nova --os-tenant-id $origin_tenant_id secgroup-list")
        echo ""
    fi
    done
done

