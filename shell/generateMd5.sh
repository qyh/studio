#!/bin/sh 

filename=$1
outfile=$2

rm -f $outfile

os=`uname -s`
md_5=md5
if [ $os = "Linux" ]; then
    md_5=md5sum
fi

while read line
do
    md5str=`printf "$line" | $md_5`
    printf "$line\t$md5str\n" >> $outfile
done < "$filename"

exit 0

