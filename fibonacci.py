#!/usr/bin/python
def fib(n):    # write Fibonacci series up to n
	a, b = 0, 1
	while b < n:
		a, b = b, a+b
		return b
print fib(int(raw_input("Print a Fibonacci series up to whatever you enter here:\n")))
