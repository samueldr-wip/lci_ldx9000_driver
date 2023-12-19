
CFLAGS=-O -Wall 


all:	testlcpd

testlcpd:	testlcpd.c
	$(CC) $(CFLAGS) testlcpd.c -o testlcpd
clean:	
	rm -f *~ testlcpd