#!/bin/sh

#Search files in recovery directory and create md5 sum

fname_md5="recovery_files.md5"

if [ "$1" ]; then
 fname_md5=$1
fi

find ./recovery -type f -name "*" -exec md5sum {} \; >$fname_md5
