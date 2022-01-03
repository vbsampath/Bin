#!/usr/bin/bash

#change to halium directory
halium=$HOME'/halium'

cd $halium

source build/envsetup.sh
breakfast treltexx
mka mkbootimg
export USE_HOST_LEX=yes
mka halium-boot
mka systemimage