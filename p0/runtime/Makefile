DEPS = runtime.o hashtable_utility.o hashtable.o hashtable_itr.o
CFLAGS=-m32 -fleading-underscore
LDFLAGS=-lm

hashtable_utility.o: hashtable_utility.c
	gcc $(CFLAGS) -c $^ -o $@

hashtable.o: hashtable.c 
	gcc $(CFLAGS) -c $^ -o $@

hashtable_itr.o: hashtable_itr.c 
	gcc $(CFLAGS) -c $^ -o $@

runtime.o: runtime.c
	gcc $(CFLAGS) -c $^ -o $@

test: test.s $(DEPS)
	gcc $(LDFLAGS) $(CFLAGS) $^ -o $@

clean:
	rm *.o
	rm test

#%.o: %.c

