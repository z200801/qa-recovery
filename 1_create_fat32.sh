#!/bin/sh

SIZE=20
FILENAME="test_fat32.img"
DIR_NAME="/home/user/mnt/test_fat32"

#dd if=/dev/zero of=$FILENAME bs=1M count=$SIZE
#mkfs.vfat $FILENAME
#echo $DIR_NAME
#mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=user $FILENAME $DIR_NAME
#sudo umount $DIR_NAME


