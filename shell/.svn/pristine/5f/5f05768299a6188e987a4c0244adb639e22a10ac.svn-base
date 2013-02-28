#!/bin/bash

# Creating a swapfile
# This script must be run as root
# usage: swapfile.sh [-k|K -g|G -m|M] value

ROOT_UID=0	# Root has $UID 0
E_WRONG_USER=65 # Not root ?

FILE=/swap
BLOCKSIZE=4096
MINBLOCKS=40
SUCCESS=0

if [ "$UID" -ne "$ROOT_UID" ]; then
    echo; echo "You must be root to run this script."; echo
    exit $E_WRONG_USER
fi

while getopts "K:k:M:m:G:g:" opt; do
    case $opt in
        k | K ) blocks=$((OPTARG)) ;;
        m | M ) blocks=$(($OPTARG * 1024)) ;;
        g | G ) blocks=$(($OPTARG * 1024 * 1024)) ;;
     
    esac

done



if [ -z "$blocks" ]; then
    blocks="$MINBLOCKS"		# Set to default of 40 blocks
fi				# if nothing specified on command line.

if [ "$blocks" -lt "$MINBLOCKS" ]; then
    blocks="$MINBLOCKS"		# Must be at least 40 blocks long
fi

echo "Creating swap file of size $blocks blocks (KB)." 
blocks=$(($blocks/4))
dd if=/dev/zero of=$FILE bs=$BLOCKSIZE count=$blocks # Zero out file
blocks=$((blocks * 4))
mkswap $FILE $blocks
swapon $FILE

echo "Swap file created and activated."

exit $SUCCESS




