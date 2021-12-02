#!/bin/sh

# TestCase 3 - Standard deletion of overwritten files with the another name
# 1. Script copy original fs container
# 2. Mounting
# 3. Delete some files
# 4. Unmount container
# 5. Mounting
# 6. Create files with another name
# 7. Unmount container

BASE_DIR=~
CUR_DIR=`pwd`
DIR_NAME="$BASE_DIR/mnt/test_fat32"
MAX_DELETE_FILES=2
FILENAME_ORIGINAL_CONTAINER="test_fat32.img"
FILENAME_TC1="test_fat32_tc2.img"
fname_sizes="1M"

# 1 copy original fs container
echo "#1 Copy container"
echo "$FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1"
cp $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC1

# 2 Mounting
echo "#2 Mount new conteiner:$CUR_DIR/$FILENAME_TC1"
mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $CUR_DIR/$FILENAME_TC1 $DIR_NAME

# 3 Delete some files
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

# 4 Unmount container
echo "#4 Unmount container: $DIR_NAME"
cd $BASE_DIR
sudo umount $DIR_NAME
rm -rf $DIR_NAME

# 5 Mounting existing conteiner
echo "#5 Mount conteiner:$CUR_DIR/$FILENAME_TC1"
mkdir -p $DIR_NAME
sudo mount --rw -t vfat -o uid=`users` $CUR_DIR/$FILENAME_TC1 $DIR_NAME

# 6 Create files with another name
echo "#6 Create files with another name"
cd $DIR_NAME ||   { echo "Failure #6 "; exit 1; }
for i in $file_will_be_delete
do
  echo "Create file:$i.new"
  dd if=/dev/urandom of="$i.new" bs=$fname_sizes count=1 status=none
done

exit 0

# 7 Unmount container
echo "#5 Unmount container: $DIR_NAME"
cd $BASE_DIR
sudo umount $DIR_NAME
rm -rf $DIR_NAME
