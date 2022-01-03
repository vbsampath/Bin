#!/bin/bash

# Get halium directory
halalias=$(cat ~/.bash_aliases | grep hal)
haldir=(${halalias//;/ })
hal=${haldir[2]}
length=${#hal}
endindex=$(expr $length - 2)
hal=${hal:0:$endindex}

cat $hal/out/target/product/treltexx/root/ueventd*.rc | grep ^/dev | sed -e 's/^\/dev\///' | awk '{printf "ACTION==\"add\", KERNEL==\"%s\", OWNER=\"%s\", GROUP=\"%s\", MODE=\"%s\"\n",$1,$3,$4,$2}' | sed -e 's/\r//' > 70-treltexx.rules
