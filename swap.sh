#!/bin/bash
echo -e "\n########################################################### CREATE SWAP MEMORY ##################################################################\n"
# size of swapfile in megabytes
#swapsize=1024
swapsize=1024

# does the swap file already exist?
grep -q "swap10" /etc/fstab

# if not then create it
if [ $? -ne 0 ]; then
        echo 'swapfile not found. Adding swapfile.'
#        fallocate -l ${swapsize}M /swap10
        dd if=/dev/zero of=/swap10 bs=1M count=${swapsize}
        chmod 600 /swap10
        mkswap /swap10
        swapon /swap10
        echo '/swap10 swap swap defaults 0 0' >> /etc/fstab
else
        echo 'swapfile found.So No changes made.'
fi

# output results to terminal
cat /proc/swaps
cat /proc/meminfo | grep Swap

exit
