#!/bin/sh

BASE_DIR=~
SIZE=20
FILENAME="test_fat32.img"
DIR_NAME="$BASE_DIR/mnt/test_fat32"

mkdir -p $DIR_NAME
dd if=/dev/zero of=$FILENAME bs=1M count=$SIZE

mkfs.vfat $FILENAME


