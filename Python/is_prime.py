def is_prime(x):
	if (x < 2):
		return False
	orig = x
	while (x > 2):
		x = x -1
		if (orig % x == 0):
			return False
		
	return True