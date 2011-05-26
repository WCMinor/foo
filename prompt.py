#!/usr/bin/python


## This script has been designed to be called instead of bash when starting a terminal
## it's only useful for sysadmins who use to work remotely most of time

## Defining the bash function

import os

def bash():
	os.system('/bin/bash')

## We create a python's dictionary with all the options, note that each name is one function

options ={	'0' : ['briana', 'ssh root@briana.traci.es'],
		'1' : ['belladona', 'ssh root@belladona.traci.es'],
		'2' : ['ecodes', 'ssh root@ecodes.org'], 
		'3' : ['panel',  'ssh root@panel.traci.es'],
		'4' : ['panel2', 'ssh root@panel2.traci.es'], 
		'5' : ['ns3',  'ssh root@ns3.traci.es'], 
		'6' : ['hispalinux', 'ssh -p 22022 root@pound.hispalinux.es'], 
		'7' : ['correo',  'ssh root@correo.traci.es'], 
		'8' : ['srv1', 'ssh -i ~/.ssh/id_rsa.bifi root@srv1.ibercivis.es'],
		'9' : ['srv2', 'ssh -i ~/.ssh/id_rsa.bifi root@srv2.ibercivis.es'], 
		'10' : ['srv3', 'ssh -i ~/.ssh/id_rsa.bifi root@srv3.ibercivis.es'], 
		'11' : ['srv4', 'ssh -i ~/.ssh/id_rsa.bifi root@srv4.ibercivis.es'], 
		'12' : ['lxbifi27', 'ssh finito@lxbifi27.bifi.unizar.es'], 
		'13' : ['eucalyptus', 'ssh -i ~/.ssh/id_rsa.bifi eucalyptus@front-ec2.bifi.unizar.es'] 
}

## Print all the options in the dic 
print "These are the traveling options:\n"
for k in sorted(options.keys(),key=int):
	print k, options[k][0]
print "\nOr any key + enter to execute bash\n"

## Get a parameter and call the correspondent function

ande = raw_input("Where are we going to:  ")
if ande in options.keys():
	os.system(options[ande][1])
else:
	# If noth0ing else was selected, execute bash

	print 'executing bash intepreter'

	bash()

quit()
