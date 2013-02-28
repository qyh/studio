#!/bin/bash

dir=$(ls "$1")

for file in "$dir"
do
	echo "$file"
	sed -i 's/\(`.*`\)/\U&/g' $file
done
exit 0
