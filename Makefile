obj-m += usblcpd.o

KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build

default: usblcpd.ko testlcpd

testlcpd: testlcpd.c
	$(CC) -o testlcpd testlcpd.c

usblcpd.ko: usblcpd.c
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

install: usblcpd.ko
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules_install

clean:
	rm *.o
	rm -f testlcpd
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean
