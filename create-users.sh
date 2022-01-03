#!/bin/sh

do_shell()
{
	adb shell "$@"
}


# Making sure device is in recovery mode to move forward
if ! adb devices | grep -q recovery; then
	echo "please make sure the device is attched via USB in recovery mode"
	exit 1
fi

# Creating users and setting up their passwords
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

echo "rebooting to system"
do_shell reboot system
