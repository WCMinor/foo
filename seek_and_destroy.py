#!/usr/bin/python

import subprocess
import glob

#set the age of the files not to remove
days='20'

#get the paths of the dirs to remove stuff

boinc_home="/var/lib/boinc/WminDG"
dcapi_paths=glob.glob("/var/lib/boinc/WminDG/master/3g-bridge/.dcapi*")
download_paths=glob.glob("/var/lib/boinc/WminDG/project/download/*")
upload_paths=glob.glob("/var/lib/boinc/WminDG/project/upload/*")

paths=[
boinc_home+"/master/3g-bridge/input/",
boinc_home+"/master/3g-bridge/output/",
]
[paths.append(i) for i in dcapi_paths]
[paths.append(i) for i in download_paths if len(i.split('/')[7]) <= 3]
[paths.append(i) for i in upload_paths if len(i.split('/')[7]) <= 3]


#clean the files
print 'cleaning files older than '+days+' days'
for i in paths:
    print 'cleaning '+i
    subprocess.call(['find', i, '-mtime', '+'+days, '-type', 'f', '-delete'])
    subprocess.call(['find', i, '-mtime', '+'+days, '-type', 'd', '-empty', '-delete'])
