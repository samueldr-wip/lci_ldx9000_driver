#! /bin/bash
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

sudo rmmod usblcpd
INCDIR=/lib/modules/`uname -r`/kernel/drivers/usb
sudo rm $INCDIR/usblcpd.ko
sudo rm $INCDIR/loadlcpd.sh
 AUTO_FILE=/etc/rc.local
 if (grep -q loadlcpd.sh $AUTO_FILE) 
  then
	sudo sed -i '/loadlcpd.sh/ d' $AUTO_FILE
	#sudo sed -i '/cd -/ d' $AUTO_FILE
	#echo "cd $INCDIR">>$AUTO_FILE
  	#echo "$INCDIR/loadlcpd.sh">>$AUTO_FILE
	#echo "cd -">>$AUTO_FILE
	#echo "exit 0">>$AUTO_FILE
	#echo "mkdir /dev/usb">>$AUTO_FILE
	#echo "mknod /dev/lcpd c 180 128">>$AUTO_FILE

  #else
  #	sed -e '/loadlcpd.sh/ c\'$INCDIR'/loadlcpd.sh' $AUTO_FILE >tmp.txt
	
  #	cp tmp.txt $AUTO_FILE
 # 	rm tmp.txt
  fi
