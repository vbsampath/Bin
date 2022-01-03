#!/bin/bash

#https://askubuntu.com/questions/19430/mount-a-virtualbox-drive-image-vdi
# https://stackoverflow.com/questions/637827/redirect-stderr-and-stdout-in-bash

user='vikram'
# Close standard output file descriptor
exec 1<&-
# Close standard error file descriptor
exec 2<&-

# Open standard output as $LOG_FILE file for read and write.
exec 1<>/home/$user/Bin/mount_halium.log

# Redirect standard error to standard output
exec 2>&1

# Check if qemu-nbd is installed otheriwse install qemu-utils
if [ ! $(which qemu-nbd) ]; then
		echo "qemu-ndb package is not installed so installing qemu-utls which provides it"
		sudo apt-get install -y qemu-utils
fi

# Variables
halium="/home/$user/Media/halium"
haliumvdi="/home/$user/halium.vdi"

### Check for dir, if not found create it using the mkdir ##
[ ! -d "$halium" ] && mkdir -p "$halium"

### Check for virtual disk, if not found exit ##
[ ! -f "$haliumvdi" ] && echo "Virtual disk doesnt exists" && exit 1

sudo modprobe nbd
sudo sleep 3
#sudo qemu-nbd -d $haliumvdi
sudo qemu-nbd -c /dev/nbd1 $haliumvdi
sudo mount /dev/nbd1p1 $halium
