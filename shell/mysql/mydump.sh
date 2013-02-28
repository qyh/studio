#!/bin/bash
# This script show how to use shell value in sed program

# Seting default host, username and password
host="127.0.0.1"
user="root"
passwd="root"

# backup dir
backupdir="$PWD"

# Print help message 
function help_msg(){
    echo "usage: $0 -h<host> -u<username> -p<password>"
    
}

# Get parameter
function get_parameter() {
    opt="$1"
    param="$2"
    if [ ${param:0:1} = "-" ]; then
        echo "-$opt need an argument"
        help_msg;
        exit 1
    else 
        printf "$param"
    fi
}

# Get options
while getopts ":h:u:p:d:" opt; do
    case $opt in
        h ) host=$(get_parameter 'h' $OPTARG) ;;
        u ) user=$(get_parameter 'u' $OPTARG) ;;
        p ) passwd=$(get_parameter 'p' $OPTARG) ;;
        d ) backupdir=$(get_parameter 'd' $OPTARG) ;;
        : ) echo "$OPTARG need an argument !"; 
            exit 1 ;;
        * ) help_msg;
            exit 1 
            ;;
    esac
done
shift $(($OPTIND - 1))

echo "$host"
echo "$user"
echo "$passwd"

# Get schemata file from database
schemata_file="$$"
mysqldump -h$host -u$user -p$passwd information_schema SCHEMATA > "$$_schemata_file"

# Get schemata file error, exit
if [  "$?" -ne 0 ]; then
    rm -f "$$_schemata_file"
    exit 1
fi

# Get contents of the line from schemata file which contains database name
databaseinfo=$(grep 'VALUES' "$$_schemata_file")
#echo "$databaseinfo"

# Fetch information from databaseinfo and assign back to databaseinfo 
databaseinfo=${databaseinfo#${databaseinfo%%(*}}
#echo "$databaseinfo"

# Get database number 
database_count=$(($(echo "$databaseinfo" | awk -F')' '{print NF}') - 1))
#echo "database_count: $database_count"

# Add a comma prefix to databaseinfo, just make it appropriate for awk to process
array=$(echo ",$databaseinfo" | awk -F')' '{for(i = 1; i < NF; i++) print $i }')

# Process every line of 'array' and fetch database name
echo "$array" | while read line
do
   databasename=$(echo "$line" | awk -F',' '{print $3}' )

   # Remvoe single quotation marks from databasename string
   databasename=${databasename#\'}
   databasename=${databasename%\'}
   #echo "$databasename"
   
   # Generate backup file name
   backupfile="$backupdir/$databasename"".sql"

   # Backup every database but information_schema
   if [ "$databasename" = "information_schema" ]; then
       continue;
   fi

   # Backup now
   printf "backup database $databasename..."
   mysqldump -h$host -u$user -p$passwd "$databasename" > "$backupfile"
   printf "Done\n"
done


# Remove temporary file 
rm -f "$$_schemata_file"
exit 0

