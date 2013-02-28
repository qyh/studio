#!/bin/bash 
# filename: img_downloader.sh

echo "parameter: $#"

if [ $# -ne 3 ]; then
    echo ;
    echo "Usage: $0 URL -d directory "
    echo 
    exit 1
fi

for i in {1..4}; do
    case $1 in 
    -d) shift directory=$1; shift;;
     *) url=${url:-$1}; shift;;
    esac
done

mkdir -p $directory;
file=$(echo "sdfs")
baseurl=$(echo $url);

curl -s $url | egrep -o "<img src=[^>]*>" |
sed 's/<img src=\"\([^"]*\).*/\1/g' > /tmp/$$.list

sed -i "s/|^/|$baseurl/|" /tmp/$$.list

cd $directory;

while read filename; do
    curl -s -o "$filename" --silent

done < /tmp/$$.list

exit 0




