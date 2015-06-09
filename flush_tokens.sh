#!/bin/bash

# Purpose of the script
# Everytime a service wants to be do 'something' it has to retrieve an autentication token
# Nova/Glance/Cinder services are manage by Pacemaker and monitor functions (from the RA) ask for a token every 10 sec
# There is no cleanup procedure nor periodical task running to delete expire token

logger -t keystone-cleaner "Starting token cleanup"
keystone-manage token_flush
logger -t keystone-cleaner "Ending token cleanup"

exit 0
