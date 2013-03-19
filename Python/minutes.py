#!/usr/bin/env python

import sys

def shortRun(x):
    print int(x/60),':',(x - int(x/60) * 60)
     

# to be used as command line tool that reads a list of numbers and converts each to minutes:seconds format 
def longRun():
	for line in sys.stdin.readlines(): 
		line = float(line)
		print int(line/60),':',(line - int(line/60) * 60)

# uncomment the function you want to use

# longRun()

while 1:
    shortRun( input("time? "))


