def bubbleSort(l, length):
    def issmallerthan(or1,or2):
        x = lambda s1, s2: x(s1 + -1,s2 + -1) if s1 != 0 and s2 != 0 else [or1,or2] if s1 == 0 else [or2,or1] 
        return x(or1,or2)
    def loop1(l, length, i):
        l = l if i == length else loop2(l,length-i,0)
        return l if i == length else loop1(l, length, i + 1)
    def loop2(l, length, j):
        l = l if j == length else swap(l,j)
        return l if j == length else loop2(l, length, j + 1)
    def swap(l, i):
        tmp = issmallerthan(l[i+1],l[i])
        l[i] = tmp[0]
        l[i+1] = tmp[1]
        return l

    return loop1(l, length-1, 0)
    
l = [4,10,6,5,50,0,4,2,4,3,1,1,6,205,56]
length = 15
print bubbleSort(l, length)
l = [45,24,0,4,15,34,9,7,8,853,145,99,49,124,56,104,253,234,45,23,1,43,4,52,3,34,2,34,564,2,24,35,57,34,3,3,4,5,4,43,553,2,8,5,532,214,452,453,452,213,66,41,346,632,663,999,435,234,456,54,456,234]
length = 62
print bubbleSort(l, length)
