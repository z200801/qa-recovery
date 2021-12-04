#!/bin/sh

# TestCase 6 - damage container
# 1. Script copy original fs container
# 2. Damage container

TESTCASE_N=6
#0x4 - 0x43 FAT0
#0x44 - 0x83 FAT1
COUNT_BYTE_TO_DAMAGE="0x40"
SEEK_TO_DAMAGE="0x44"
. ./tc_function_unit.sh

# ==========================================================================================
# Main
echo "#0 Making and fill container"
clear
mnt_container=$(search_mount_container)
if [ $mnt_container ]; then { echo "Failure: conteiner mounted:$mnt_container"; exit 1; } fi

echo "#0 Making and fill container"
create_and_fill_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT

# 1 copy original fs container to modify container
echo "#1 Copy container"
cp $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $TESTCASE_DIR/$FILENAME_TC

damage_container $TESTCASE_DIR/$FILENAME_TC $COUNT_BYTE_TO_DAMAGE $SEEK_TO_DAMAGE
compare_containers $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $TESTCASE_DIR/$FILENAME_TC

