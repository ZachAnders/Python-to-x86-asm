def fib(n, first, second, current, end):
    n = current if current <= 1 else first + second
    first = 0 if current <= 1 else second
    second = 1 if current <= 1 else n
    return fib(n, first, second, current + 1, end + -1) if end > 0 else n

print fib(0, 0, 0, 0, input())
