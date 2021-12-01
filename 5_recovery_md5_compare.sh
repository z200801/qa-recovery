#!/bin/sh

#Search files in recovery directory and create md5 sum

fname_md5_recovery="recovery_files.md5"

if [ -x "$1" ]; then
    echo "Requre\n$0 [original_md5_file] {recovery_md5_file}"
    exit 1
fi

fname_md5_original=$1

if [ "$2" ]; then
 fname_md5_recovery=$2
fi

ii=0
fl_md5=`cat $fname_md5_recovery`
for i in $fl_md5
do
    ii=$((${ii%}+1))
    echo "ii=$ii"
    echo $i
done
