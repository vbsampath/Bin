#!/usr/bin/bash

sudo systemctl stop $1
sudo systemctl disable $1
sudo cp /home/vikram/Bin/systemd/$1 /etc/systemd/system/
sudo systemctl enable $1
sudo systemctl daemon-reload
sudo systemctl reset-failed
