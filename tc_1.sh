#!/bin/sh

# TestCase 1 - Standard file deletion
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

# 1 copy original fs container
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1

# 2 Mounting
echo "#2 Mount new conteiner"
mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $FILENAME_TC1 $DIR_NAME

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

# 4 Unmount container
echo "#4 Unmount container: $DIR_NAME""
sudo umount $DIR_NAME
rm -rf $DIR_NAME
