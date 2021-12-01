#!/bin/sh

# TestCase 2
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Create files with name deleted files
# 5. Unmount container

BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MAX_DELETE_FILES=2
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC1="test_fat32_tc2.img"
fname_sizes="1M"

# 1
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1

# 2
echo "#2 Mount new conteiner"
mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $FILENAME_TC1 $DIR_NAME

# 3
echo "#3 Delete some files"
echo "cd to directory $DIR_NAME"
cd $DIR_NAME ||   { echo "Failure #3 "; exit 1; }
file_will_be_delete=`find . -type f -name "*"| shuf -n $MAX_DELETE_FILES`
# file_all=`find . -type f -name "*"`

for i in $file_will_be_delete
do
  echo "Delete file:$i"
  rm $i
done

# 4
echo "#4 Create files"
for i in $file_will_be_delete
do
  echo "Create file:$i"
  dd if=/dev/urandom of=$i bs=$fname_sizes count=1 status=none
done


# 5
echo "#5 Unmount container: $DIR_NAME""
sudo umount $DIR_NAME
rm -rf $DIR_NAME
