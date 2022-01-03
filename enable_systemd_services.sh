#!/usr/bin/bash

sudo cp $HOME/Bin/systemd/$1 /etc/systemd/system
sudo systemctl enable $1
sudo systemctl daemon-reload
sudo systemctl reset-failed
