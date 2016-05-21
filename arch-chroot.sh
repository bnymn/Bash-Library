#!/bin/bash
CHROOT=${1}
PROC_DIR=$CHROOT"/proc"
SYS_DIR=$CHROOT"/sys"
DEV_DIR=$CHROOT"/dev"
RUN_DIR=$CHROOT"/run"

ERROR=1
if [ -d $PROC_DIR ]; then
	if [ -d $SYS_DIR ]; then
		if [ -d $DEV_DIR ]; then
			if [ -d $RUN_DIR ]; then
				ERROR=0
			fi
		fi
	fi
fi

if [ $ERROR=0 ]; then
	cd $CHROOT
	cp /etc/resolv.conf ./etc
	
	mount -t proc /proc $PROC_DIR
	mount --rbind /sys $SYS_DIR
	mount --rbind /dev $DEV_DIR
	mount --rbind /run $RUN_DIR
	
	chroot $CHROOT /bin/bash
fi
