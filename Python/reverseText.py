def reverse(text):
	size = len(text)
	newtext = ''
	while (size > 0):
		newtext = newtext + text[size-1]
		print newtext
		size = size - 1
	return newtext
	
reverse('hello')
reverse('racecar')