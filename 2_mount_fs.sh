#!/bin/sh

FILENAME="test_fat32.img"
BASE_DIR=~
DIR_NAME="$BASE_DIR/mnt/test_fat32"

mkdir -p $DIR_NAME

if [ "$1" ]; then
 FILENAME=$1
fi

sudo mount --rw -t vfat -o uid=`users` $FILENAME $DIR_NAME




