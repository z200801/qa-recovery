#!/bin/sh

#Search files in recovery directory and create md5 sum

if [ -x "$1" ]; then
    echo "Requre\n$0 [original_md5_file] [recovery_md5_file]"
    exit 1
fi

if [ -x "$2" ]; then
    echo "Requre\n$0 [original_md5_file] [recovery_md5_file]"
    exit 1
fi
 echo "Compare recovery files"
 cat $1 $2| sort |uniq -d
