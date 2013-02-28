#!/bin/bash

backup_dir="$2"
host="$1"
if [ "$host" = "" ]; then
    host="127.0.0.1"
fi
if [ "$backup_dir" = "" ]; then
    backup_dir="$PWD"
fi

# Get schemata file from database
schemata_file="$$"
mysqldump -h$host -uroot -proot information_schema SCHEMATA > "$schemata_file"

if [ $? -nq 0 ]; then
    exit 1
fi

file="$schemata_file"
# Using temp file
tmpfile="$file"".tmp"

# Get the line that contain all database name 
line=$(grep 'VALUES' "$file")

#echo "$line"

database=${line#${line%%(*}}
echo "$database" > "$tmpfile"

# Get database number : line_count - 1
line_count=$(awk -F')' '{print NF}' "$tmpfile" )
#echo "$line_count"

# Print database name to "~line~file~" file
awk -F')' '{for(i = 1; i < NF; i++) print $i > "~line~file~"}' "$tmpfile"

#echo "$line" > "~line~file~"
#awk -F')' '{print $0, NF}' "$file"".tmp" 

# Rename "~line~file~" to tempfile
mv "~line~file~" "$tmpfile"

# Read line from tempfile
while read line
do
    #echo "$line"
    line=${line#*(}
    touch "~line~file~"
    # Print to "~line~file~" again
    echo "$line" >> "~line~file~"
done < "$tmpfile"
mv "~line~file~" "$tmpfile"

# Get Databases name 
count=$(awk -F',' '{print $2}' "$tmpfile")
echo "$count"> "$tmpfile"

while read line ; do
    
    line=${line#\'}
    line=${line%\'}
    if [ "$line" != "information_schema" ] \
    && [ "$line" != "test" ]; then
        echo ""
        echo "backup database $line now..."
        backupfile="$backup_dir/""$line"".sql"
        mysqldump -h$host -uroot -proot "$line" > "$backupfile"
cat << !here! >>  mysqldb.sql
use $line;
source $backupfile;          
!here!
        echo "database: $line backup success!"
    fi
done < "$tmpfile"

# Remove temp file
rm -f "$tmpfile"
rm -f "$schemata_file"

echo ""
echo "All database backup success!"
echo "You can use mysqldb.sql to recover database now!"


