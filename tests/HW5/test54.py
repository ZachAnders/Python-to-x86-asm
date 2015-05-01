def simple_func(x,y,z):
    def inner_func(x,y):
        print x
        print y
    print x
    print y
    print z
    inner_func(x,y)

simple_func(23,65,12)
