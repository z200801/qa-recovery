#!/bin/sh

# TestCase 4 - Standard file deletion with not normal dismounting (force unmount)
# 0. Making and fill container
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Force Unmount container

TESTCASE_N=4
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

# 2 Mounting
echo "#2 Mount new conteiner"
echo "$TESTCASE_DIR/$FILENAME_TC"
mount_container $TESTCASE_DIR/$FILENAME_TC $DIR_MOUNT

# 3 Deleting files
echo "#3 Deleting files"
delete_files_in_container $MAX_DELETE_FILES

# 4 Force Unmount container
echo "#4 Force Unmount container: $DIR_MOUNT"
umount_container_force $DIR_MOUNT

mnt_container=$(search_mount_container)
if [ $mnt_container ]; then { echo "Failure: conteiner mounted:$mnt_container";} fi
