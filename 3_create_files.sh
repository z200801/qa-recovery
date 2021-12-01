#!/bin/sh

#Create test file with filling from /dev/urandom and calculate md5 sum

BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MOUNT_FILENAME=`mount|grep \`users\`|grep mnt|awk {'print $1'}|sed 's/.*\///'`

fname_sizes="1M"

MAX_DIR=2
MAX_FILES=2
TEST_DIRNAME="test"
TEST_FILENAME="test_file"
TEST_FILE_EXT="dat"

file_md5=$CUR_DIR/$MOUNT_FILENAME.md5

mkdir $DIR_NAME/$TEST_DIRNAME
touch $file_md5

for i_dir in `seq 1 $MAX_DIR`
do
    dr1=$DIR_NAME/$TEST_DIRNAME/$TEST_DIRNAME"-"$i_dir
    mkdir -p $dr1
    for i_file in `seq 1 $MAX_FILES`
    do
     fl1=$dr1/$TEST_FILENAME"_"$i_dir"_"$i_file"."$TEST_FILE_EXT
     dd if=/dev/urandom of=$fl1 bs=$fname_sizes count=1 status=none
    done
done

cd $DIR_NAME
find . -type f -name "*" -exec md5sum {} \; >$file_md5
