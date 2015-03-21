def is_smaller_than(x,y):
    return is_smaller_than(x+-1,y+-1) if x != 0 and y != 0 else True if x == 0 else False
def div(x,y):
    d = lambda result,x,y: result if is_smaller_than(x,y) else d(result+1,x-y, y)
    return 1 if is_smaller_than(x,y) else d(1,x,y)

print div(6,2)
print div(9,3)
print div(12,2)
print div(2,2)
print div(2,1)
print div(50,1)
print div(5,30)
print div(17,3)
