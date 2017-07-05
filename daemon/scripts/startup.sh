#! /bin/sh

sudo ./mountPHD.sh

# mount --bind means that when we access the second folder, in fact we are accessing the first folder 
sudo mount --bind /mnt/harddisk /home/vsftpd/ftpuser/harddisk
sudo mount --bind /mnt/harddisk2 /home/vsftpd/ftp_hayden/harddisk2
