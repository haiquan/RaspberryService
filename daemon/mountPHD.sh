#!/bin/sh

# mount the portable hard drive
LogFile=/home/pi/daemon/mount.log

#sudo mount -t ntfs /dev/sda7 /samba

# check whether harddisk is already mounted.
ret=$(sudo ls /mnt/harddisk | grep movie)
if [ "$ret" != "" ]; then
    echo "everything is ok."
    exit 0
fi

ret=$(sudo fdisk -l | grep sda)
if [ "$ret" != "" ]; then
    echo "mount sda" | tee -a $LogFile
    sudo mount -o rw -t ntfs /dev/sda6 /mnt/harddisk
    sudo mount -o rw -t ntfs /dev/sda8 /mnt/harddisk2
fi
ret=$(sudo fdisk -l | grep sdb)
if [ "$ret" != "" ]; then
    echo "mount sdb" | tee -a $LogFile
    sudo mount -o rw -t ntfs /dev/sdb6 /mnt/harddisk
    sudo mount -o rw -t ntfs /dev/sdb8 /mnt/harddisk2
fi
