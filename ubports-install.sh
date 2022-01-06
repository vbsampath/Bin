#!/bin/bash

user="vikram"
code="zerofltexx"
environment="halium9"

case "$code" in
    zerofltexx)
        halium9="ubuntu-touch-android9-arm64.tar.gz"
        halium7="ubports-touch.rootfs-xenial-arm64.tar.gz"
        ;;
    treltexx)
        halium9="ubuntu-touch-android9-armhf.tar.gz"
        halium7="ubports-touch.rootfs-xenial-armhf.tar.gz"
        ;;
esac

img=/home/$user/halium/out/target/product/$code/system.img


adb push /home/$user/halium/out/target/product/$code/halium-boot.img /sdcard
adb shell "dd if=/sdcard/halium-boot.img of=/dev/block/bootdevice/by-name/BOOT"

echo "Halium-boot.img is transfered and installed in boot partition."

cd /home/$user/Programs/github/repositories/halium-install/

case "$environment" in
    "halium7")
        sudo ./halium-install -p ut -u 123 -k /home/$user/.ssh/ubports.pub /home/$user/Downloads/$halium7 $img
        ;;
    "halium9")
        sudo ./halium-install -p ut -u 123 -s -k /home/$user/.ssh/ubports.pub /home/$user/Downloads/$halium9 $img
        ;;
esac

echo "Removing old ssh keys"
ssh-keygen -f /home/$user/.ssh/known_hosts -R 10.15.19.82

echo "Adding new fingerprint"
ssh-keyscan -H 10.15.19.82 >> /home/$user/.ssh/known_hosts

echo "Done with installation. Now rebooting"
adb reboot
