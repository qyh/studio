#!/bin/bash

mount -o iocharset=utf8 -t vfat /dev/sda5 /mnt/studio
mount -t ntfs-3g /dev/sda1 /mnt/win7
mount -t ntfs-3g /dev/sda6 /mnt/soft
mount -t ntfs-3g /dev/sda7 /mnt/media
mount -t ntfs-3g /dev/sda8 /mnt/opt
mount -t ntfs-3g /dev/sda9 /mnt/vmware
mount -t ext4 /dev/sda10 /mnt/mint
exit 0
