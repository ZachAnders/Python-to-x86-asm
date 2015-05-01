class c:
    x = [10,32,40,5]
    i = 3

o = c
while c.i != -1:
    c.i = c.i + -1
    c.x[c.i] = c.x[c.i] + 5
    print c.x 

print o.x
