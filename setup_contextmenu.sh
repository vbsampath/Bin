#!/usr/bin/bash

echo "Setting up context menu instead of printscreen"
xmodmap -e 'keycode 107 = Menu NoSymbol Menu'
