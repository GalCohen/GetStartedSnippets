def anti_vowel(text):
	newText = ""
	for letter in text:
		if  not (letter in "aeiou" or letter in "AEIOU"):
			newText = newText + letter
			print newText
	return newText
	
anti_vowel("Hey You!")