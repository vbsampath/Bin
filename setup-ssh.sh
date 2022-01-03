#!/bin/sh

sudo ip link set eth0 address 02:11:22:33:44:55
sudo ip address add 10.15.19.100/24 dev eth0
sudo ip link set eth0 up
 
