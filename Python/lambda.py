
my_list = range(16)
print filter(lambda x: x % 3 == 0, my_list)




languages = ["HTML", "JavaScript", "Python", "Ruby"]
print filter(lambda x: x == "Python", languages)




squares = range(1, 11)

squares = [x**2 for x in range(1,11) if (x**2 == x**2)]
print squares

print filter(lambda x: x > 30 and x < 70, squares)