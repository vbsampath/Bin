#!/bin/sh

reboot=true
do_shell()
{
	adb shell "$@"
}


# Making sure device is in recovery mode to move forward
if ! adb devices | grep -q recovery; then
	echo "please make sure the device is attched via USB in recovery mode"
	exit 1
fi


# Creating recovery directory for halium-install to work
DIR=/recovery
COMMAND='[ -e '"$DIR"' ] && echo $?'
IS_EXIST=`do_shell $COMMAND`
if [ -n "$IS_EXIST" ]; then
  echo "$DIR is exist."
else
   do_shell "mkdir recovery"
   echo "recovery directory created"
fi


# Setting up halium-install process
HALIUM_ISNTALL_DIR=$HOME/Modding/Halium-Rootfs

halium-install-mod $HALIUM_ISNTALL_DIR/halium-rootfs-20170630-151006.tar.gz $HALIUM_ISNTALL_DIR/New/system.img


# Creating users and setting up their passwords
echo "Setting up ssh user password"
do_shell "mkdir /a"
do_shell "mount /data/rootfs.img /a"
do_shell 'chroot /a /bin/bash <<EOT
echo "setting up environment"
. /etc/environment

echo "setting up root password"
echo "root:123" | chpasswd
'

# if id sam &>/dev/null; then
#     echo user sam found
# else
#     useradd sam
#     echo user sam added
# fi
#
# echo "setting up sam password"
# echo "sam:123" | chpasswd

do_shell "umount /a"
do_shell "rmdir /a"
do_shell "sync"
echo "ssh user password done"

if $reboot ; then
    echo "rebooting to system"
    do_shell reboot system
fi
