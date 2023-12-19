#
# Makefile borrowed from acer_acpi
#

ifneq ($(KERNELRELEASE),)

obj-m += usblcpd.o

else

KERNELVERSION = `uname -r`
KERNELSRC := /lib/modules/$(KERNELVERSION)/build
KERNELMAJOR = $(shell echo $(KERNELVERSION) | head -c3)

obj-m += usblcpd.o

INCLUDE = -I$(KERNELSRC)/include

ifneq ($(KERNELMAJOR), 3.8)
exit_24:
endif

all: usblcpd.ko

exit_24:
	@echo "No support for 2.4 series kernels"

help:
	@echo Possible targets:
	@echo -e all\\t- default target, builds kernel module
	@echo -e install\\t- copies module binary to /lib/modules/$(KERNELVERSION)/extra/
	@echo -e clean\\t- removes all binaries and temporary files

usblcpd.ko:
	$(MAKE) -C $(KERNELSRC) SUBDIRS=$(PWD) modules

clean:
	rm -f *~ *.o *.s *.ko *.mod.c .*.cmd Module.symvers modules.order
	rm -rf .tmp_versions

install:
	mkdir -p ${DESTDIR}/lib/modules/$(KERNELVERSION)/extra
	cp -v usblcpd.ko ${DESTDIR}/lib/modules/$(KERNELVERSION)/extra/
	depmod -a

endif
