#!/bin/sh

#Search files in recovery directory and create md5 sum

fname_md5="recovery_files.md5"
CUR_DIR=`pwd`

if [ "$1" ]; then
 fname_md5=$1
fi

cd recovery
find . -type f -name "*" -exec md5sum {} \; >$CUR_DIR/$fname_md5
