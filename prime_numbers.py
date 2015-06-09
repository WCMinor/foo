#!/usr/bin/python

c = 0.0

def prime(c):
    
    global primes
    cc=c.__div__(xrange(c))
    primes = []
    cc = str(c).split('.')
    print cc[1]
#    if cc[1] == '0':
#        primes.append(c)

for c in xrange(11):
    prime(c)

print primes
