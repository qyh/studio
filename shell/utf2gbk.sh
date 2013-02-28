#!/bin/sh

# File -- gbk2utf8.sh
# Author: qyh
# Date: 2012-3-18
# This script use to convert the file which coded with gbk or gb2312
# to utf8.
# Notice: gbk2utf8.sh and gbkutf8.py must be use together(put them to the
# same directory)

# Get the first parameter.
# When the parameter is a directory, the script will convert all the file
# which in the directory. So I strongly recommend you to back up your file
# to another directory within the directory before you convert it.
dir="$1"

# Exit and print help message, if it's null
if [ "$dir" = "" ]; then
    echo "Usage: $0 filename or directory"
    exit 1
fi

dirname=${0%/*}

# When the parameter is a file
if [ -f "$dir" ]; then
    
    # Get the first character of filename
    preffix=${dir%${dir#/}}
    
    # Whether it's an absolute path
    if [ "$preffix" != "/" ]; then
        # Set it to an absolute path
        dir=$PWD/$dir
    fi
    echo "$dir"
    # Invoke gbk2utf8.py and convert 
    $dirname/utf2gbk.py $dir > /dev/null 2>&1
    exit 0
fi

# When the parameter is a directory
for file in $(find $dir -name '*'); do
    
    # Get the first character of filename
    preffix=${file%${file#/}}
    
    # Whether it's an absolute path
    if [ "$preffix" != "/" ]; then
        # Set it to an absolute path
        file=$PWD/$file
    fi
    
    # Convert file only(ignore directory)
    if [ -f "$file" ]; then    
        echo $file
        $dirname/utf2gbk.py $file > /dev/null 2>&1
    fi
done

exit 0
