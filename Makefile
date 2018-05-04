.PHONY: all check clean runbench

COMPILE_OBJ = gcc -Wall -shared -O3 -c

OBJS = encode.o decode.o

all: fb64

%.o: %.c
	$(COMPILE_OBJ) $<

test: test.c $(OBJS)
	gcc -Wall -O3 -o $@ $^

example: example.c $(OBJS)
	gcc -Wall -o $@ $^

check: example test
	./example > /dev/null
	./test

bench: benchmark.cpp $(OBJS)
	g++ -std=gnu++17 -Wall -O3 -o $@ $^ -I../modp ../modp/modp_b64.o -lbenchmark ../proxygen/proxygen/lib/.libs/libproxygenlib.a  -lssl -lcrypto -lglog

runbench: bench
	./bench

clean:
	rm -f *.o test example fb64

fb64: fb64.c $(OBJS)
	gcc -Wall -O3 -o $@ $^
