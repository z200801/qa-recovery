#!/bin/sh

SIZE=20
FILENAME="test_fat32.img"
DIR_NAME="/home/user/mnt/test_fat32"

dd if=/dev/zero of=$FILENAME bs=1M count=$SIZE
mkfs.vfat $FILENAME


