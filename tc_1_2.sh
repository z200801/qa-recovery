#!/bin/sh
. ./tc_function_unit.sh

# ==========================================================================================
# Main
echo "#0 Making and fill container"
rm -rf $TESTCASE_DIR
mkdir -p $TESTCASE_DIR
mkdir -p $TESTCASE_DIR/$RECOVERY_DIR

making_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT $SIZE_CONTAINER
mount_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT
create_files_in_container
umount_container $DIR_MOUNT

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

# 4 Unmount container
echo "#4 Unmount container: $DIR_MOUNT"
umount_container $DIR_MOUNT
