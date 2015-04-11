class Calc:
    def __init__(self):
        self.last = 0

    def mult(self,x,y):
        result = 0
        while y:
            result = result + x
            y = y + -1
        self.last = result
        return result

    def div(self,x,y):
        count = 0
        if y == 1:
            return x
        if y == 0:
            return 0
        while x:
            x = x + -y
            count = count + 1
        self.last = count
        return count
    
    def exp(self,x,y):
        while y:
            x = x + x
            y = y + -1
        self.last = x
        return x

C = Calc()
print C.mult(25,60)
d = C.last
print C.div(d,60)
print C.exp(2,4)
print C.mult(C.last,2)
