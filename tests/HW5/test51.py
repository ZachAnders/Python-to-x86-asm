def func(x):
    return 5 + (lambda: -5 + x)()
print func(input())
