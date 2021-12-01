#!/bin/sh

FILENAME="test_fat32.img"
DIR_NAME="/home/user/mnt/test_fat32"

mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=user $FILENAME $DIR_NAME


