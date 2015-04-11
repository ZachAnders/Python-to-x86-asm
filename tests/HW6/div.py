def div(x,y):
    count = 0
    if y == 1:
        return x
    if y == 0:
        return 0
    while x:
        x = x + -y
        count = count + 1
    return count

print div(10,2)
print div(500,5)
print div(9,3)
print div(12,4)
