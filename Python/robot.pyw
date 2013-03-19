import random
import time
import os
import sys
from Quartz.CoreGraphics import CGEventCreateMouseEvent
from Quartz.CoreGraphics import CGEventPost
from Quartz.CoreGraphics import kCGEventMouseMoved
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseUp
from Quartz.CoreGraphics import kCGMouseButtonLeft
from Quartz.CoreGraphics import kCGHIDEventTap
from Quartz.CoreGraphics import CGEventCreateKeyboardEvent

DOWN_ARROW = 125
UP_ARROW = 126
LEFT_ARROW = 123
RIGHT_ARROW = 124

def mouseEvent(type, posx, posy):
	theEvent = CGEventCreateMouseEvent(None, type, (posx,posy), kCGMouseButtonLeft)
	CGEventPost(kCGHIDEventTap, theEvent)

def mousemove(posx,posy):
	print 'mousemove...'
	mouseEvent(kCGEventMouseMoved, posx,posy)

def mouseclick(posx,posy):
	print 'mouseclick'
	mouseEvent(kCGEventLeftMouseDown, posx,posy)
	mouseEvent(kCGEventLeftMouseUp, posx,posy)

def pushZ():
	print 'pushz'
	cmd = """
	osascript -e 'tell application "System Events" to keystroke "z"' 
	"""
	return cmd


def pushDownKey():
	print 'pushdownkey'
	cmd = """
	osascript -e 'tell application "System Events" to key code 125' 
	"""
	return cmd


def pushArrowKey(key):
	print 'pusharrowkey:'+str(key)
	cmd = """
	osascript -e 'tell application "System Events" to key code """+str(key)+""" ' 
	"""
	return cmd


def randPushZ():
	num = random.randint(1, 7)
	time.sleep(num)
	os.system(pushZ())


def afkMouseMove():
	mouseclick(64, 400)
	mousemove(100, 200)
	time.sleep(1)
	mousemove(123, 212)
	time.sleep(1)
	mousemove(72, 150)
	mouseclick(72, 152)



def main():
	# 	cmd = """
	#	osascript -e 'tell application "System Events" to key code 125' 
	#   """
	#	os.system(cmd)

	afkcount = 0;
	afkrand = random.randint(1, 300)

	time.sleep(3)
	print 'started...'
	print 'afkrand:'+str(afkrand)
	while 1 == 1:
		pushArrowKey(RIGHT_ARROW)	
		pushArrowKey(RIGHT_ARROW)	
		os.system(pushZ())
		os.system(pushZ())
		# os.system(pushDownKey())
		# os.system(pushDownKey())
		# os.system(pushDownKey())
		# os.system(pushDownKey())
		os.system(pushArrowKey(DOWN_ARROW))
		os.system(pushArrowKey(DOWN_ARROW))
		os.system(pushArrowKey(DOWN_ARROW))
		os.system(pushArrowKey(DOWN_ARROW))
		
		randPushZ()
		randPushZ()
		randPushZ()

		afkcount += 1
		print str(afkcount)
		if (afkcount >= afkrand):
			print 'afk test'
			afkcount = 0
			afkrand = random.randint(1, 300)
			afkMouseMove()
			pushArrowKey(LEFT_ARROW)	
			time.sleep(1)
			pushArrowKey(LEFT_ARROW)	
			time.sleep(1)
			pushArrowKey(LEFT_ARROW)	
			time.sleep(1)
			pushArrowKey(UP_ARROW)
			time.sleep(1)
			pushArrowKey(UP_ARROW)
			time.sleep(1)
			pushArrowKey(DOWN_ARROW)
			time.sleep(1)
			pushArrowKey(DOWN_ARROW)
			time.sleep(1)
			pushArrowKey(RIGHT_ARROW)
			time.sleep(1)
			pushArrowKey(RIGHT_ARROW)


if __name__ == '__main__':
	main()