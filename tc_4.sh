#!/bin/sh

# TestCase 4 - Standard file deletion with not normal dismounting (force unmount)
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Force unmount container

TESTCASE=4
BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MAX_DELETE_FILES=2
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC1="test_fat32_tc1.img"
FILENAME_TC="test_fat32_tc$TESTCASE.img"

# 1 copy original fs container
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC

# 2 Mounting
echo "#2 Mount new conteiner"
mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $FILENAME_TC $DIR_NAME

# 3 Delete some files
echo "#3 Delete some files"
echo "cd to directory $DIR_NAME"
cd $DIR_NAME ||   { echo "Failure #3 "; exit 1; }
file_will_be_delete=`find . -type f -name "*"| shuf -n $MAX_DELETE_FILES`
file_all=`find . -type f -name "*"`

for i in $file_will_be_delete
do
  echo "Delete file:$i"
  rm $i
done

# 4 Unmount container with kill process
echo "#4 force unmount container : $DIR_NAME"
# umount -f -> Force unmount
sudo umount -f $DIR_NAME
cd $BASE_DIR
rm -rf $DIR_NAME
