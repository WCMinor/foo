#!/usr/bin/python

import fnmatch
import os
import subprocess

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
'/srv/guse/guse/apache-tomcat-6.0.36/temp/liferay',
'jar']


dirs = []
files = []
#add stuff but from the dci_bridge dir
#add files
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/'):
  for path in filenames:
      files.append(os.path.join(root, path))
#add dirs
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/'):
  for path in dirnames:
      dirs.append(os.path.join(root, path))

for exclude in excludes:
    dirs = [line for line in dirs if not exclude in line]
for exclude in excludes:
    files = [line for line in files if not exclude in line]

#add stuff belonging to the submission service in the dci_bridge
#add files
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/dci_bridge/0/'):
  for path in filenames:
      files.append(os.path.join(root, path))

#add dirs
for root, dirnames, filenames in os.walk('/srv/guse/guse/apache-tomcat-6.0.36/temp/dci_bridge/0/'):
  for path in dirnames:
      dirs.append(os.path.join(root, path))

#clean the files
print 'cleaning files older than '+days+' days'
for i in files:
    print 'cleaning '+i
    subprocess.call(['find', i, '-mtime', '+'+days, '-type', 'f', '-delete'])
#clean the dirs
print 'cleaning empty dirs older than '+days+' days'
for i in dirs:
    print 'cleaning '+i
    subprocess.call(['find', i, '-mtime', '+'+days, '-type', 'd', '-empty', '-delete'])
