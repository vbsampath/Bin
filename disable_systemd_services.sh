#!/usr/bin/bash

sudo systemctl stop $1
sudo systemctl disable $1
sudo systemctl daemon-reload
sudo systemctl reset-failed
