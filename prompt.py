#!/usr/bin/python


## This script has been designed to be called instead of bash when starting a terminal
## it's only useful for sysadmins who use to work remotely most of time

## Defining the bash function
priv_key="~/.ssh/id_rsa.finito"
import os

def bash():
	print 'executing bash intepreter'
	os.system('/opt/local/bin/bash')
	quit()
## We create a python's dictionary with all the options, note that each name is one function
key=1
options = {}
with open("server.list") as f:
	for line in f:
		options[int(key)] = line.split()
		key=key+1

# Print all the options in the dic 

print "These are the traveling options:\n"
for k in sorted(options.keys(),key=int):
	print k, options[k][3]
print "\nOr any key + enter to execute bash\n"

# Get a parameter and call the correspondent function

ande = raw_input("Where are we going to:  ")
try:
	ande = int(ande)
except ValueError:
	bash()

if ande in options.keys():
	key, user, url = options[ande][1], options[ande][2], options[ande][3]
	ssh="ssh ","-i ",key, " ", user+"@"+url
	os.system("".join(ssh))
else:
	# If noth0ing else was selected, execute bash


	bash()

quit()
