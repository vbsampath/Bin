#!/usr/bin/bash

#change to repos directory
repos=$HOME'/Programs/github/repositories/'

cd $repos

git clone -b cm-14.1-treltexx https://github.com/vbsampath/hybris-boot.git
git clone -b hybris-14.1 https://github.com/vbsampath/android.git
git clone -b cm-14.1-treltexx https://github.com/vbsampath/android_kernel_samsung_exynos5433.git
git clone -b cm-14.1 https://github.com/vbsampath/android_device_samsung_trelte-common.git
git clone -b cm-14.1 https://github.com/vbsampath/android_hardware_samsung.git
