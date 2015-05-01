class d0:
    a = 20
    b = 5

class d1:
    a = 600
    c = 87
    d = 32

class d2:
    b = 20
    d = 5
    c = 5
    h = 12

class e(d0,d1,d2):
    z = 4
    h = 3

d = e.a + e.b + e.c + e.d + e.h + e.z
print d
