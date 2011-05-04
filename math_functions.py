#!/usr/bin/python
# sum one and one
def oneandone():
	import time
	print "\n\nEntering 1 + 1 math function\n\n"
	time.sleep(2)
	print "Combinating parallel heuristic processes\n\n"
	time.sleep(3)
	print "Downloading results from Blue Gene NASA cluster\n\n"
	print 2

# write Fibonacci series up to n
def fib():
	n = int(raw_input("Print a Fibonacci series up to whatever you enter here:\n"))
	a, b = 0, 1
	while b < n:
		a, b = b, a+b
		print a

def math_functions():

## We create a python's dictionary with all the options, note that each name is one function

	options ={      1 : ['prints the Fibonacci series from 0 to the given number', fib, 'fibonacci'],
			2 : ['sums one and one', oneandone, '1+1']
		}

## Print all the options in the dic 
	print "\n\nThese are the available math functions:\n"
	for k in options.keys():
        	print options[k][2], "  ", options[k][0], "\n"




#Ask fir a function name and execute it

	fun = raw_input("\n\nSo, which function are we using?\nPlease enter the function name:\n")
        for k in options.keys():
		if fun in options[k][2]:
			options[k][1]()
		else:
			pass

math_functions()
