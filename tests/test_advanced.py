a=1
in1 = input()
b=2+in1
in2 = input()
c=3+in2
in3 = input()
d=4+in3
in4 = input()
e=5+in4
in5 = input()
f=6+in5
in6 = input()
g=7+in6
in7 = input()
h=8+in7
in8 = input()
i=9+in8
in9 = input()
j=10+in9


print a+b+c+d+e+f+g+h+i+j

# Cycle references
tmp=a; a=b;b=c;c=d;d=e;e=f;f=g;g=h;h=i;i=j;j=tmp
tmp=a; a=b;b=c;c=d;d=e;e=f;f=g;g=h;h=i;i=j;j=tmp
tmp=a; a=b;b=c;c=d;d=e;e=f;f=g;g=h;h=i;i=j;j=tmp
tmp=a; a=b;b=c;c=d;d=e;e=f;f=g;g=h;h=i;i=j;j=tmp
tmp=a; a=b;b=c;c=d;d=e;e=f;f=g;g=h;h=i;i=j;j=tmp
tmp=a; a=b;b=c;c=d;d=e;e=f;f=g;g=h;h=i;i=j;j=tmp

print a+b+c+d+e+f+g+h+i+j
print a
print c
print e
print g
print i
