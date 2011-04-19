#!/usr/bin/python


## This script has been designed to be called instead of bash when starting a terminal
## it's only useful for sysadmins who use to work remotely most of time

## Defining all the functions

import os

def bash():
	os.system('/bin/bash')
	quit()

def briana():
	os.system('ssh root@briana.traci.es')
	quit()

def belladona():
	os.system('ssh root@belladona.traci.es')
	quit()

def ecodes():
	os.system('ssh root@ecodes.org')
	quit()

def ns3():
	os.system('ssh root@ns3.traci.es')
	quit()

def panel():
	os.system('ssh root@panel.traci.es')
	quit()

def panel2():
	os.system('ssh root@panel2.traci.es')
	quit()

def hispalinux():
	os.system('ssh -p 22022 root@pound.hispalinux.es')
	quit()

def correo():
	os.system('ssh root@correo.traci.es')
	quit()

def srv1():
	os.system('ssh -i ~/.ssh/id_rsa.bifi root@srv1.ibercivis.es')
	quit()

def srv2():
	os.system('ssh -i ~/.ssh/id_rsa.bifi root@srv2.ibercivis.es')
	quit()

def srv3():
	os.system('ssh -i ~/.ssh/id_rsa.bifi root@srv3.ibercivis.es')
	quit()

def srv4():
	os.system('ssh -i ~/.ssh/id_rsa.bifi root@srv4.ibercivis.es')
	quit()

## We create a pythons dictionary with all the options, note that each name is one function

options ={	0 : briana,
		1 : belladona,
		2 : ecodes,
		3 : panel, 
		4 : panel2, 
		5 : ns3, 
		6 : hispalinux, 
		7 : correo, 
		8 : srv1, 
		9 : srv2, 
		10 : srv3, 
		11 : srv4, 
}

## Print all the options in the dic 

print "These are the traveling options:\n"
for k, d in options.iteritems():
	print k, options[k].func_name
print "\nOr any key + enter to execute bash\n"

## Get a parameter prevent any error if the human doesn't type a number

def ira():
	try:
		ret = int(raw_input("Where are we going to:  "))
		return ret
	except ValueError:
		pass
ande = ira()

##call the correspondent function

for i in range(12):
	if i == ande:
		options[i]()

# If noth0ing else was selected, execute bash

print 'executing bash intepreter'
import time
time.sleep(1)

bash()

quit()
