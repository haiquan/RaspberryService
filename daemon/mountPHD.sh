#!/bin/sh

# mount the portable hard drive
LogFile=/home/pi/daemon/log_mount.log

#sudo mount -t ntfs /dev/sda7 /samba

# check whether harddisk is already mounted.
ret=$(sudo ls /mnt/harddisk2 | grep tv)
if [ "$ret" != "" ]; then
    echo "everything is ok."
    exit 0
fi

# umount the harddisk
sudo umount -l /mnt/harddisk
sudo umount -l /mnt/harddisk2

time=$(date "+%Y/%m/%d %H:%M:%S")

ret=$(sudo fdisk -l | grep sda)
if [ "$ret" != "" ]; then
    echo "mount sda, $time" | tee -a $LogFile
    sudo mount -t ntfs /dev/sda6 /mnt/harddisk
    sudo mount -t ntfs /dev/sda5 /mnt/harddisk2
fi
ret=$(sudo fdisk -l | grep sdb)
if [ "$ret" != "" ]; then
    echo "mount sdb, $time" | tee -a $LogFile
    sudo mount -t ntfs /dev/sdb6 /mnt/harddisk
    sudo mount -t ntfs /dev/sdb5 /mnt/harddisk2
fi
ret=$(sudo fdisk -l | grep sdc)
if [ "$ret" != "" ]; then
    echo "mount sdc, $time" | tee -a $LogFile
    sudo mount -t ntfs /dev/sdc6 /mnt/harddisk
    sudo mount -t ntfs /dev/sdc5 /mnt/harddisk2
fi

# mount --bind means that when we access the second folder, in fact we are accessing the first folder 
sudo mount --bind /mnt/harddisk /home/vsftpd/ftpuser/harddisk
sudo mount --bind /mnt/harddisk2 /home/vsftpd/ftp_hayden/harddisk2
