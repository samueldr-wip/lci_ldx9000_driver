#! /bin/bash

REL=`uname -r`
MACH=`uname -m`
#set the path, point to kernel source code base folder.
#
#INCDIR=/usr/src/kernels/$REL-$MACH/
INCDIR=/lib/modules/`uname -r`/build

if !(gcc --version >&/dev/null)
then
  echo "gcc is not in your path."
  echo ""
  exit 1
fi

echo "Using [include] path: $INCDIR"
echo "Remove all old files"
#rm -f *.ko
rm -f *.o
echo "Building Module... "
make -C $INCDIR SUBDIRS=$PWD modules
echo "Done!"
