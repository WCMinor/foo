#!/bin/bash
for l in /sys/class/net/eth*; do
iface=`lspci| grep SFP|awk '{print $1}'`
if [ $iface ]
then
ifacename=`udevadm info -a -p $l|grep "$iface"|grep eth|cut -d/ -f6|cut -c1-4`
#echo "$ifacename" >> ifaces.txt
echo "$ifacename"
fi
done
