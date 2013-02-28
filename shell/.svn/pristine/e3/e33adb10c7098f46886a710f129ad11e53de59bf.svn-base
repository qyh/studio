#!/bin/bash

device="$1"
hwaddr=""
bootproto="dhcp"
onboot="yes"
nm_controlled="yes"

if [ "$bootproto" = "static" ]; then
    if [ "$device" = "" ] || [ "$ipaddr" = "" ]; then
        echo "Usage: $0 \"ethx\" ipaddress"
        exit 1
    fi
fi

file="/etc/sysconfig/network-scripts/ifcfg-$device"
if [ ! -f "$file" ]; then
    touch "$file"
fi
#cp "$file" "$file""_backup"
#echo "$old_gateway"
#value="${old_gateway#*=}"
#echo "value:$value"


cat << !here! > "$file"
$comment
DEVICE=$device
HWADDR=$hwaddr
BOOTPROTO=$bootproto
NM_CONTROLLED=$nm_controlled
ONBOOT=$onboot
!here!
chattr -i /etc/resolv.conf
rm /etc/resolv.conf

#ifdown "$device"
#ifup "$device"
/etc/rc.d/init.d/network restart

