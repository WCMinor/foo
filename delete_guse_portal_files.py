#!/usr/bin/python

import fnmatch
import os
import subprocess
import re

#set the age of the files not to remove
days='20'

#get the paths of the dirs to remove stuff
excludes=['/srv/guse/guse/apache-tomcat-6.0.36/temp/dci_bridge',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/repository',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/SHIWA',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/storage',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/uploads',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/submittedwflog',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/users',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/WFI_logg',
'/srv/guse/guse/apache-tomcat-6.0.36/temp/liferay']


paths = []
#add stuff but from the dci_bridge dir
#add dirs
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/'):
  for path in dirnames:
      paths.append(os.path.join(root, path))
#add files
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/'):
  for path in filenames:
      paths.append(os.path.join(root, path))
paths = [dir for dir in paths if not re.match(excludes, dir)]
#add stuff belonging to the submission service in the dci_bridge
#add dirs
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/dci_bridge/0/'):
  for path in dirnames:
      paths.append(os.path.join(root, path))
#add files
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/dci_bridge/0/'):
  for path in filenames:
      paths.append(os.path.join(root, path))

#clean the files
print 'cleaning files older than '+days+' days'
for i in paths:
    print 'cleaning '+i
#uncomments the follow to do the real removal
#    subprocess.call(['find', i, '-mtime', '+'+days, '-type', 'f', '-delete'])
#    subprocess.call(['find', i, '-mtime', '+'+days, '-type', 'd', '-empty', '-delete'])
