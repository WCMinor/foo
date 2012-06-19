#!/usr/bin/python


## This script has been designed to be called instead of bash when starting a terminal
## it's only useful for sysadmins who use to work remotely most of time
## you need a file called .server.list in your home directory, see the example one in the repo

# Defining the bash function
import os

def bash():
	print 'executing bash intepreter'
	os.system('/opt/local/bin/bash')
	quit()


# Create a python's dictionary reading the options from the file "server.list"
key=1
options = {}
with open(".server.list") as f:
	for line in f:
		options[int(key)] = line.split()
		key=key+1

# Print all the options in the dic

print "These are the traveling options:\n"
for k in sorted(options.keys(),key=int):
	print k, options[k][3]
print "\nOr any key + enter to execute bash\n"

# Get a parameter and execute the correspondent ssh command
# In both cases, you enter not a number or you enter a number that's not in the list, bash is executed

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
	bash()

quit()
