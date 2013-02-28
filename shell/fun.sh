#!/bin/bash
# include custom lib
. lib.sh


#echo "local ip: $(get_localip)"
#echo "internal net: $(get_local_iface)"
#echo "gateway: $(get_gateway_ip)"
#echo "memory size: $(get_mem_size)"
#echo "hdd_size: $(get_hdd_size)"
#echo "non sys user: $(find_non_sys_user)"

checkipv4 $1


exit 0
