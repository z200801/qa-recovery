#!/bin/sh

DIR_NAME="/home/user/mnt/test_fat32"

fname_sizes="1M"

MAX_DIR=2
MAX_FILES=2
TEST_DIRNAME="test"
TEST_FILENAME="test_file"
TEST_FILE_EXT="txt"

mkdir $DIR_NAME/$TEST_DIRNAME

for i_dir in `seq 1 $MAX_DIR`
do
    dr1=$DIR_NAME/$TEST_DIRNAME/$TEST_DIRNAME"-"$i_dir
    echo $dr1
    mkdir -p $dr1
    for i_file in `seq 1 $MAX_FILES`
    do
    fl1=$dr1/$TEST_FILENAME"_"$i_dir"_"$i_file
    fl2=$fl1"."$TEST_FILE_EXT
    fl3=$fl1"_new."$TEST_FILE_EXT
     echo $fl2
     fallocate -l $fname_sizes $fl2
     sed 's/[^~]/A/g' $fl2>$fl3
     rm $fl2
    done
done







