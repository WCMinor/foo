#!/usr/bin/python

# write Fibonacci series up to n
def fib(n):
	a, b = 0, 1
	while b < n:
		a, b = b, a+b
		print a
fib(int(raw_input("Print a Fibonacci series up to whatever you enter here:\n")))
