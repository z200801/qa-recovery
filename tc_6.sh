#!/bin/sh

# TestCase 6 - damage container
# 1. Script copy original fs container
# 2. Damage container

TESTCASE=6
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC="test_fat32_tc$TESTCASE.img"
#0x4 - 0x43 FAT0
#0x44 - 0x83 FAT1
SEEK_TO_DAMAGE="0x44"
COUNT_BYTE_TO_DAMAGE="0x40"
CHAR_TO_DAMAGE="\x01"

# 1 copy original fs container
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC

# 6 Damage conteiner
echo "#6 Damage conteiner"
#printf $CHAR_TO_DAMAGE | dd of=$FILENAME_TC bs=1 seek=$(($SEEK_TO_DAMAGE)) count=1 conv=notrunc
dd if=/dev/urandom of=$FILENAME_TC bs=1 count=$(($COUNT_BYTE_TO_DAMAGE)) seek=$(($SEEK_TO_DAMAGE)) conv=notrunc status=none
echo "#6 Compare files"
cmp -b -c $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC
