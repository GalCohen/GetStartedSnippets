import sys
import os
import time
from Quartz.CoreGraphics import CGEventCreateMouseEvent
from Quartz.CoreGraphics import CGEventPost
from Quartz.CoreGraphics import kCGEventMouseMoved
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseUp
from Quartz.CoreGraphics import kCGMouseButtonLeft
from Quartz.CoreGraphics import kCGHIDEventTap
from Quartz.CoreGraphics import CGEventCreateKeyboardEvent


def mouseEvent(type, posx, posy):
		theEvent = CGEventCreateMouseEvent(None, type, (posx,posy), kCGMouseButtonLeft)
		CGEventPost(kCGHIDEventTap, theEvent)
def mousemove(posx,posy):
		mouseEvent(kCGEventMouseMoved, posx,posy)
def mouseclick(posx,posy):
		mouseEvent(kCGEventLeftMouseDown, posx,posy)
		mouseEvent(kCGEventLeftMouseUp, posx,posy)

def keypress(keycode):
	theEvent = CGEventCreateKeyboardEvent(None, keycode, True)
	theEvent2 = CGEventCreateKeyboardEvent (None, keycode, False);

def main():
	# mousemove(0,0)
	keypress(125)
	keypress(125)
	keypress(125)
	keypress(125)
	keypress(6)

	for i in range(3):
		print i
		cmd = """
		osascript -e 'tell application "System Events" to key code 125' 
		"""
		os.system(cmd)

		cmd = """
		osascript -e 'tell application "System Events" to keystroke "z"' 
		"""
		os.system(cmd)

		cmd = """
		osascript -e 'tell application "System Events" to key code 125' 
		"""
		os.system(cmd)


		cmd = """
		osascript -e 'tell application "System Events" to keystroke "z"' 
		"""
		os.system(cmd)



if __name__ == '__main__':
	main()