#!/bin/bash

halium7="ubports-touch.rootfs-xenial-armhf.tar.gz"
halium7img=$HOME/halium/out/target/product/treltexx/system.img
halium9="ubuntu-touch-android9-armhf.tar.gz"
#halium9img="$HOME/Downloads/Generic-Aonly-10-20191211-ErfanGSI.img"
halium9img=$HOME/halium/out/target/product/treltexx/system.img
environment="halium9"

adb push $HOME/halium/out/target/product/treltexx/halium-boot.img /sdcard
adb shell "dd if=/sdcard/halium-boot.img of=/dev/block/bootdevice/by-name/BOOT"

echo "Halium-boot.img is transfered and installed in boot partition."

cd $HOME/Programs/github/repositories/halium-install/

case "$environment" in
    "halium7")
        sudo ./halium-install -p ut -u 123 -k $HOME/.ssh/ubports.pub $HOME/Downloads/$halium7 $halium7img
        ;;
    "halium9")
        sudo ./halium-install -p ut -u 123 -s -k $HOME/.ssh/ubports.pub $HOME/Downloads/$halium9 $halium9img
        ;;
esac

echo "Removing old ssh keys"
ssh-keygen -f $HOME/.ssh/known_hosts -R 10.15.19.82

echo "Adding new fingerprint"
ssh-keyscan -H 10.15.19.82 >> $HOME/.ssh/known_hosts

echo "Done with installation. Now rebooting"
adb reboot
