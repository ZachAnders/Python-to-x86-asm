def mult(x,y):
    result = 0
    while y:
        result = result + x
        y = y + -1
    return result

print mult(100,95)
print mult(5,25)
print mult(23,2)
print mult(45,5)
