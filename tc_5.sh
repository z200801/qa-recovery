#!/bin/sh

# TestCase 5 - formating container
# 1. Script copy original fs container
# 2. Formating container

TESTCASE=5
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC="test_fat32_tc$TESTCASE.img"

# 1 copy original fs container
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC

#2. Formating container
echo "#2 Formating container"
mkfs.vfat $FILENAME_TC
