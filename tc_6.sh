#!/bin/sh

# TestCase 6 - damage container
# 1. Script copy original fs container
# 2. Damage container

TESTCASE=6
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC="test_fat32_tc$TESTCASE.img"
SEEK_TO_DAMAGE="0x100"
COUNT_BYTE_TO_DAMAGE="128"
CHAR_TO_DAMAGE="\x01"

# 1 copy original fs container
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC

# 6 Damage conteiner
echo "#6 Damage conteiner"
printf $CHAR_TO_DAMAGE | dd of=$FILENAME_TC bs=1 seek=$(($SEEK_TO_DAMAGE)) count=1 conv=notrunc
echo "#6 Compare files"
cmp -b -c $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC
