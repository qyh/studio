#!/bin/bash
# This script show how to use shell value in sed program

inputfile="$1"
spaces=""
width=4

while getopts "w:" opt; do
    case $opt in
        w ) width=$(($OPTARG));;
        
    esac
done
shift $(($OPTIND - 1))

#echo "width: $width"
#echo "spaces: $spaces"

inputfile="$1"
for ((i=0; i < width; i++))
do
    spaces="$spaces"" "
done

# Change tab to specify width space
sed -i 's/	/\'"$spaces"'/g' "$inputfile"

