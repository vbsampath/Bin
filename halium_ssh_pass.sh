#!/bin/sh

# creating .ssh directory if not exists
if [ -d .ssh ]; then
    mkdir ~/.ssh
fi

# copy ssh public and private keys
cp ./ssh/* ~/.ssh/

echo "Copied keys from source"

# copy keys to server
ssh-copy-id -i ~/.ssh/halium root@10.15.19.82

echo "Copied keys from source to server"

