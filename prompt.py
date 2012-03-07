#!/usr/bin/python


## This script has been designed to be called instead of bash when starting a terminal
## it's only useful for sysadmins who use to work remotely most of time

## Defining the bash function

import os

def bash():
	os.system('/opt/local/bin/bash')

## We create a python's dictionary with all the options, note that each name is one function

options ={	'0' : ['briana', 'ssh -i ~/.ssh/id_rsa.finito root@briana.traci.es'],
		'1' : ['belladona', 'ssh -i ~/.ssh/id_rsa.finito root@belladona.traci.es'],
		'2' : ['ecodes', 'ssh -i ~/.ssh/id_rsa.finito root@ecodes.org'], 
		'3' : ['panel',  'ssh -i ~/.ssh/id_rsa.finito root@panel.traci.es'],
		'4' : ['panel2', 'ssh -i ~/.ssh/id_rsa.finito root@panel2.traci.es'], 
		'5' : ['acms', 'ssh -i ~/.ssh/id_rsa.finito root@acms.traci.es'],
		'6' : ['ns3',  'ssh -i ~/.ssh/id_rsa.finito root@ns3.traci.es'], 
		'7' : ['hispalinux', 'ssh -p 22022 -i ~/.ssh/id_rsa.finito root@pound.hispalinux.es'], 
		'8' : ['correo',  'ssh -i ~/.ssh/id_rsa.finit oroot@correo.traci.es'], 
		'9' : ['srv1', 'ssh -i ~/.ssh/id_rsa.bifi root@srv1.ibercivis.es'],
		'10' : ['srv2', 'ssh -i ~/.ssh/id_rsa.bifi root@srv2.ibercivis.es'], 
		'11' : ['srv3', 'ssh -i ~/.ssh/id_rsa.bifi root@srv3.ibercivis.es'], 
		'12' : ['srv4', 'ssh -i ~/.ssh/id_rsa.bifi root@srv4.ibercivis.es'], 
		'13' : ['zgz_openstack', 'ssh -i ~/.ssh/id_rsa.bifi root@front-ec2.bifi.unizar.es'],
		'14' : ['UoW_dgserver', 'ssh -i ~/.ssh/id_rsa.finito root@161.74.91.78'], 
		'15' : ['UoW_ngs', 'ssh -i ~/.ssh/id_rsa.finito ferrerd@ngs.wmin.ac.uk'],
		'16' : ['UoW_test-DG-server', 'ssh -i ~/.ssh/id_rsa.finito root@10.20.151.55'],
		'17' : ['UoW_ecs-docs', 'ssh -i ~/.ssh/id_rsa.finito root@docs.ecs.westminster.ac.uk'],
		'18' : ['UoW_spiderman', 'ssh -i ~/.ssh/id_rsa.finito ferrerd@spiderman.cpc.wmin.ac.uk'],
		'19' : ['UoW_dg-server2', 'ssh -i ~/.ssh/id_rsa.finito root@dg-server2.wmin.ac.uk'],
		'20' : ['UoW_dg-portal', 'ssh -i ~/.ssh/id_rsa.finito root@dg-portal.wmin.ac.uk'],
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
