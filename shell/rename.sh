#!/bin/sh

dir=$1
echo "$dir"

function rename()
{
    param=$1;
    ls $param | grep '\[.*\]' |  while read line
    do
        if [ ! -f "$line" ]; then
            # When "$line" doesn't a file
            continue
        fi
        postfix=${line#*]}
        prefix=${line%%[*}
        newname="$prefix$postfix"
        echo "rename $line to $newname..."
        #mv $line $newname
        #echo "done !"
    done
}
rename $dir
exit 0

