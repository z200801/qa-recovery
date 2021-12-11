#!/bin/sh

# TestCase 5 - formating container
# 0. Making and fill container
# 1. Script copy original fs container
# 2. Formating container


TESTCASE_N=5
. ./tc_function_unit.sh
TEST_FILE_EXT="db"
SIZE_CONTAINER=100
MAX_DIR=4
MAX_FILES=4
fname_sizes="2M"

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

#2. Formating container
echo "#2 Formating container"
formating_container $TESTCASE_DIR/$FILENAME_TC
