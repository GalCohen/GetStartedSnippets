import os
from subprocess import call

startDIR = 'TEST'
endDIR = 'TEST2'

files = os.listdir(startDIR)
print files

for item in files:
    print item
    newItem = item[:-3]
    newItem = newItem + "jpg"
    print newItem
    call(["convert", "-verbose", startDIR+"/"+item, endDIR+"/"+newItem])