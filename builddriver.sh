#! /bin/bash
if [ -d /lib/modules/`uname -r`/build/include ] ; then
  INCDIR=/lib/modules/`uname -r`/build/include
elif [ -d /usr/src/linux ] ; then
  INCDIR=/usr/src/linux/include
elif [ -d /usr/src/linux-2.4 ] ; then
  INCDIR=/usr/src/linux-2.4/include
else [ -f /usr/include/linux/string.h ]
  INCDIR=/usr/include
fi

if !(gcc --version >&/dev/null)
then
  echo "gcc is not in your path, can not continue!"
  echo ""
  exit 1
fi
RES=`grep warning $INCDIR/linux/string.h`

if [ "$RES" != "" ] ; then
  echo You do not appear to have the kernel src installed.
  echo If you do, please create a link called /usr/src/linux and point it to it
  exit 1
fi

echo "Using kernel source from $INCDIR"
echo -n "Building Module...  "
gcc -D__KERNEL__ -I$INCDIR -DMODULE -Wall -O -c usblcpd.c -o usblcpd.o
echo "Done!"
