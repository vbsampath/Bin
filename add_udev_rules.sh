#!/bin/bash

modding=$HOME/Modding
key=~/.ssh/halium
server=root@10.15.19.82

cat $modding/70-treltexx.rules | ssh -i $key $server 'cat > /tmp/udev.rules'
ssh -i $key $server "cp /tmp/udev.rules /etc/udev/rules.d/70-treltexx.rules"

