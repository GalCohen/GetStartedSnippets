from random import randrange

random_number = randrange(1, 10)

count = 0

while (count < 3):
	guess = int(raw_input("Enter a guess:"))
	if (random_number == guess):
		print "You win!"
		break
	else:
		count += 1
else:
	print "You lose."
		

	
