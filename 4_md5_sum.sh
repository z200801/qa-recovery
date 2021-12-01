#!/bin/sh

#Search files in directory and create md5 sum

BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MOUNT_FILENAME=`mount|grep \`users\`|grep mnt|awk {'print $1'}|sed 's/.*\///'`

fname_md5="some_files.md5"
CUR_DIR=`pwd`
fname_md5="$CUR_DIR/$MOUNT_FILENAME.md5"

if [ "$1" ]; then
    DIR_NAME=$1
fi

if [ "$2" ]; then
  fname_md5="$CUR_DIR/$2"
fi


cd $DIR_NAME
#find . -type f -name "*" -exec md5sum {} \; >$CUR_DIR/$fname_md5
find . -type f -name "*" -exec md5sum {} \; >$fname_md5
