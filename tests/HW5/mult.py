def mult(x,y):
    m = lambda val, y: m(val+x ,y + -1) if y != 1 else val
    return m(x,y)
print mult(5,5)
print mult(9,21)
