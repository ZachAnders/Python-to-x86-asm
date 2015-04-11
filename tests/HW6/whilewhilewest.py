x = 20
y = 50
class m:
    print 1 + 1 + 1 + 1
    def __init__(self):
        self.x = 0
    def getX(self):
        return self.x
    def setX(self, x):
        self.x = x

obj = m()

while x and y:
    obj.setX(x+y+obj.getX())
    x = x + -1
    if x:
        y = y + 1
    else:
        y = y - 2

print obj.getX()
