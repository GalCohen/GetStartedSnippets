def censor(text, word):
	asterisks = "*"*len(word)
	wordlist = text.split()
	newText = []
	for w in wordlist:
		if (w == word):
			newText.append(asterisks)
		else:
			newText.append(w)
	print newText
	newText = " ".join(newText)
	return newText
	
censor("this hack is wack hack", "hack")