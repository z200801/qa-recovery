#!/bin/sh

# TestCase 3 - Standard deletion of overwritten files with the new name
# 0. Making and fill container
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Unmount container
# 5. Mounting
# 6. Create files with new name deleted files
# 7. Unmount container


TESTCASE_N=3
. ./tc_function_unit.sh
TEST_FILE_EXT="dat"
MAX_DELETE_FILES=4
SIZE_CONTAINER=100
MAX_DIR=4
MAX_FILES=4
fname_sizes="2M"

TEST_FILE_EXT="db"
NEW_EXT="new"
MAX_DELETE_FILES=4

# ====================================================================================
# Main
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

# 4 Unmount container
echo "#4 Unmount container: $DIR_MOUNT"
umount_container $DIR_MOUNT

mnt_container=$(search_mount_container);
if [ $mnt_container ]; then
  { echo "Failure: conteiner mounted:$mnt_container"
    lsof|grep "home/user/mnt/test_fat32"
}
fi

# 5 Mounting
echo "#5 Mount new conteiner"
echo "$TESTCASE_DIR/$FILENAME_TC"
mount_container $TESTCASE_DIR/$FILENAME_TC $DIR_MOUNT

# 6 Create files with name deleted files
echo "#6 Create files with new name deleted files"
create_files_new_names_in_container

# 7 Unmount container
echo "#7 Unmount container: $DIR_MOUNT"
umount_container $DIR_MOUNT

mnt_container=$(search_mount_container)
if [ $mnt_container ]; then { echo "Failure: conteiner mounted:$mnt_container";} fi
