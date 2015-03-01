# Down_The_Rabbit_Hole.py

a = [2]
b = a
print a
print b
# Expected Output:
# [2]
# [2]

tr = [0,1]
tr[0] = tr
tr[1] = tr
print tr[0][1][0][1][0][1][0][1][0][1][0][1][0][1][0][1][0][1][0][1][0][1]
# Expected Output:
# [[...], [...]]
