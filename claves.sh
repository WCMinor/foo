#!/bin/bash
 
if [ $# -ne 2 ]
then
echo "Usage: $0  "
echo
echo "Example: $0 WLAN_C58D 64:68:0C:C5:C5:90"
exit 1
fi
 
HEAD=$(echo -n "$1" | tr 'a-z' 'A-Z' | cut -d_ -f2)
BSSID=$(echo -n "$2" | tr 'a-z' 'A-Z' | tr -d : )
BSSIDP=$(echo -n "$BSSID" | cut -c-8)
KEY=$(echo -n bcgbghgg$BSSIDP$HEAD$BSSID | md5 | cut -c-20)
 
echo "$KEY\n"
