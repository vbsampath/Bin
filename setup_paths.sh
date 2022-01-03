#!/bin/bash

# Paths to be added
bin=/home/$USER/Bin/
halium=/home/$USER/Media/halium/halium
halium_boot=/home/$USER/Media/halium/halium/halium/halium-boot/
halium_scripts=/home/$USER/Programs/github/repositories/halium-scripts/
mer_kernel_check=/home/$USER/Programs/github/repositories/mer-kernel-check/

bashrc=~/.bashrc
aliases=~/.bash_aliases

append_aliases()
{
    echo alias ll="'ls -alFh'" >> $aliases
    echo alias df="'df -h'" >> $aliases
    echo alias ..="'cd ..'" >> $aliases
    echo alias 2.="'cd ../..'" >> $aliases
    echo alias 3.="'cd ../../..'" >> $aliases
    echo alias 4.="'cd ../../../..'" >> $aliases
    echo alias 5.="'cd ../../../../..'" >> $aliases
    echo alias hal="'cd $halium'" >> $aliases
    echo alias bin="'cd $bin'" >> $aliases
    echo alias ssn="'ssh -i ~/.ssh/halium root@10.15.19.82'" >> $aliases
}
append_paths()
{
    echo "" >> $bashrc
    echo "# Adding additional paths" >> $bashrc
    echo export PATH=\"$bin:\$PATH\" >> $bashrc
    echo export PATH=\"$halium:\$PATH\" >> $bashrc
    echo export PATH=\"$halium_boot:\$PATH\" >> $bashrc
    echo export PATH=\"$halium_scripts:\$PATH\" >> $bashrc
    echo export PATH=\"$mer_kernel_check:\$PATH\" >> $bashrc
}
if ! echo $PATH | grep Modding >/dev/null; then
    echo "Additional paths are not set, adding them into path"
    if [ -f $bashrc ]; then
        echo ".profile exists so appending to it"
        append_paths
    else
        echo ".profile file doesnt exists"
    fi
else
    echo "Additional paths are already added"
fi


# Appending aliases
if [ -f $aliases ]; then
    if cat $aliases | grep "hal" >/dev/null; then
        echo 'aliases exists'
    else
        echo "appending aliases"
        append_aliases
    fi
else
    echo ".bash_aliases file doesnt exists so creating new ones"
    touch $aliases
    append_aliases
fi

source $bashrc
