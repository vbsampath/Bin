#!/bin/bash

USBNETWORK=$(sudo dmesg | grep rndis | grep -oh '\w*eth0\w*' | tail -n 1)

echo "Debug: RNDIS: $USBNETWORK"
echo "##########################"

sudo ip link set $USBNETWORK address 02:01:02:03:04:08

# Enable this line for ssh
sudo ip address add 10.15.19.100 dev $USBNETWORK

# Enable this line for telnet
#sudo ip address add 192.168.2.50 dev $USBNETWORK

sudo ip address show dev $USBNETWORK
sudo ip route  add 10.15.19.82 dev $USBNETWORK

# Enable this line for ssh
ping -c 4 10.15.19.82

# Enable this line for telnet
#ping -c 4 192.168.2.15

echo "Setting up Internet Access Over USB"
sudo sysctl net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $USBNETWORK -o enp3s0 -j ACCEPT
echo "Done, type:"
echo
echo "ip route add default via 10.15.19.100"
echo 
echo "Once Connected"
echo
echo "+------------------------+"
echo "| Device: $USBNETWORK    |"
echo "| IP: 10.15.19.82        |"
echo "| MAC: 02:01:02:03:04:08 |"
echo "+------------------------+"

#https://www.putorius.net/automatically-accept-ssh-fingerprint.html
# Enable this for ssh
ssh -i /home/vikram/.ssh/ubports -o "StrictHostKeyChecking no" phablet@10.15.19.82
#ssh -i ~/.ssh/ubports root@10.15.19.82

# Enable this for telnet
#telnet 192.168.2.15
