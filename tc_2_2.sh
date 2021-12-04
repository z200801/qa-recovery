#!/bin/sh

TESTCASE_N=2
. ./tc_function_unit.sh

# TestCase 2 - Standard deletion of overwritten files with the same name
# 0. Making and fill container
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Unmount container
# 5. Mounting
# 6. Create files with name deleted files
# 7. Unmount container



# ==========================================================================================
# Main
echo "#0 Making and fill container"
rm -rf $TESTCASE_DIR
mkdir -p $TESTCASE_DIR
mkdir -p $TESTCASE_DIR/$RECOVERY_DIR

#echo "#0: Making container"
#making_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT $SIZE_CONTAINER
#echo "#0: Mount container"
#mount_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT
#echo "#0: Create files in container"
#create_files_in_container
#echo "#0: UnMount container"
#umount_container $DIR_MOUNT

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

# 5 Mounting
echo "#5 Mount new conteiner"
echo "$TESTCASE_DIR/$FILENAME_TC"
mount_container $TESTCASE_DIR/$FILENAME_TC $DIR_MOUNT

# 6 Create files with name deleted files
echo "#6 Create files with name deleted files"
create_files_some_names_in_container

# 7 Unmount container
echo "#7 Unmount container: $DIR_MOUNT"
umount_container $DIR_MOUNT
