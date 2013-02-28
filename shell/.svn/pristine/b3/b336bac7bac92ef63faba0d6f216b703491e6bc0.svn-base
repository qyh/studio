#!/bin/bash

device="$1"
hwaddr=""
bootproto="static"
broadcast=""
ipaddr="$2"
netmask="255.255.255.0"
gateway=""
network=""
onboot="yes"
nm_controlled="yes"

if [ "$device" = "" ] || [ "$ipaddr" = "" ]; then
    echo "Usage: $0 \"ethx\" ipaddress"
    exit 1
fi

file="/etc/sysconfig/network-scripts/ifcfg-$device"
if [ ! -f "$file" ]; then
    touch "$file"
fi
#cp "$file" "$file""_backup"
#echo "$old_gateway"
#value="${old_gateway#*=}"
#echo "value:$value"

device=$(ifconfig "$device" | grep 'HWaddr' | awk '{print $1}')

hwaddr=$(ifconfig "$device" | grep 'HWaddr' | awk '{print $5}')

broadcast=${ipaddr%.*}".255"

gateway=${ipaddr%.*}".1"


network=${ipaddr%.*}".0"


comment=$(grep '#' "$file")
if [ "$comment" = "" ]; then
    comment="# Here is the ip configuration file"
fi
cat << !here! > "$file"
$comment
DEVICE=$device
HWADDR=$hwaddr
BOOTPROTO=$bootproto
IPADDR=$ipaddr
NETMASK=$netmask
NETWORK=$network
BROADCAST=$broadcast
GATEWAY=$gateway
NM_CONTROLLED=$nm_controlled
ONBOOT=$onboot
!here!
nameserverfile="/etc/resolv.conf"
if [ ! -f "$nameserverfile" ]; then
    touch "$nameserverfile"
fi
chattr -i /etc/resolv.conf
cat << EOF > /etc/resolv.conf
nameserver 202.101.224.69
nameserver 202.101.226.68
EOF
chattr +i /etc/resolv.conf
ifdown "$device"
ifup "$device"

