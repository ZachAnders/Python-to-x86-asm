def bubbleSort(l, length):
    def loop1(l, length, i):
        l = loop2(l, length - i, 0) if i < length else l
        return l if i == length else loop1(l, length, i + 1)

    def swap(l, i):
        tmp1 = l[i+1] if l[i+1] < l[i] else l[i]
        tmp2 = l[i] if l[i+1] < l[i] else l[i+1]
        l[i] = tmp1
        l[i+1] = tmp2
        return l

    def loop2(l, length, j):
        l = swap(l, j) if j < length else l
        return l if j == length else loop2(l, length, j + 1)

    return loop1(l, length-1, 0)
    
l = [4,10,30,5,340,0,4,2,4,3,1,1,6]
length = 13
print bubbleSort(l, length)
l = [45,3404,0,4,-5,-34,9,7,8,-10345,999,49,3024,904956,345904,3453,234234,545,23,1,43,4,523,3,34,2,34,564,2,-24,345,-567,234,3,3,4,5,4,43,4553,2,8,5,634532,3214,456452,23453,3452,213,3566,2341,346,4632,663,435,234,-456,-54,6456,2234]
length = 60
print bubbleSort(l, length)
