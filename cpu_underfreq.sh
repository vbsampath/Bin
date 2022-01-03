#!/bin/bash

sudo cpupower frequency-set -g powersave # set governor profile to powersave
sudo cpupower frequency-set --max 2200000  # set max CPU freq to 2.2GHz
