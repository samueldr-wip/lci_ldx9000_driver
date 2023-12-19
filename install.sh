#!/bin/bash
clear
echo Welcome to the Logic Controls PD Kernel module installer.
echo ""
#make sure it's root
USER=`whoami`
if [[ "$USER" != "root" ]] ; then
  echo "You must be root to install this module."
  echo "Can not continue."
  echo ""
  exit 1
fi

if !(./builddriver.sh) || [ ! -f usblcpd.o ] 
then
  echo "Kernel source is not installed"
  echo "your system will use the driver in this package"
  echo ""
  
fi

echo ""
echo "Creating /dev entries... "
mkdir /dev/usb
if !(mknod /dev/usb/lcpd c 180 128) ; then
	echo "Failed to create /dev entry"
fi

#if [ -d /lib/modules/`uname -r`/build/include ] ; then
  INCDIR=/lib/modules/`uname -r`/kernel/drivers/usb
#fi
echo "Copy usb pd driver to: $INCDIR"

#echo -n "."
cp usblcpd.ko $INCDIR
cp loadlcpd.sh $INCDIR
echo " Done!"

echo "Add PD driver setting file to /etc/rc.d/rc.local."
  
  AUTO_FILE=/etc/rc.local

  if !(grep -q loadlcpd.sh $AUTO_FILE) 
  then
	echo "cd $INCDIR">>$AUTO_FILE
  	echo "$INCDIR/loadlcpd.sh">>$AUTO_FILE
	echo "cd -">>$AUTO_FILE
	echo "mkdir /dev/usb">>$AUTO_FILE
	echo "mknod /dev/usb/lcpd c 180 128">>$AUTO_FILE

  #else
  #	sed -e '/loadlcpd.sh/ c\'$INCDIR'/loadlcpd.sh' $AUTO_FILE >tmp.txt
	
  #	cp tmp.txt $AUTO_FILE
 # 	rm tmp.txt
  fi
./loadlcpd.sh

echo ""

 


