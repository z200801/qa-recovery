#!/bin/sh

#TestCase 1
#1. Script copy original fs container
#2. Mounting
#3. Delete some files
#4. Unmount container

BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MAX_DELETE_FILES=2
FILENAME="test_fat32.img"

mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $FILENAME $DIR_NAME


file_will_be_delete=`find . -type f -name "*"| shuf -n $MAX_DELETE_FILES`

for i in $file_will_be_delete
do
  echo $i
done

