#!/bin/sh 

file="$1"
todir="$2"

if [ "$todir" = "" ]; then
    todir=studio
fi

if [ "$file" = "" ]; then
    echo "usage: $0 <filename>"
    exit 1
fi

if [ -f "$file" ]; then
    scp -rp $file qinyanhong@freebsd.unix-center.net:~/$todir
    exit 0
fi
for f in `find $file -name '*'`; do
    if [ ! -d "$f" ]; then
        scp -rp $f qinyanhong@freebsd.unix-center.net:~/$todir
    fi
done


exit 0
