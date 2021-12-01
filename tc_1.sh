#!/bin/sh

# TestCase 1
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Unmount container

BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MAX_DELETE_FILES=2
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC1="test_fat32_tc1.img"

# 1
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1

# 2
mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $FILENAME_TC1 $DIR_NAME

# 3
cd $DIR_NAME ||   { echo "Failure #3 "; exit 1; }
file_will_be_delete=`find . -type f -name "*"| shuf -n $MAX_DELETE_FILES`

for i in $file_will_be_delete
do
  echo $i
done

# 4
sudo umount $DIR_NAME
rm -rf $DIR_NAME