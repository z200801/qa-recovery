#!/bin/sh



TESTCASE=$TESTCASE_N
BASE_DIR=~
CUR_DIR=`pwd`
cur_user=`users`
cur_user="user"

TESTCASE_DIR=$CUR_DIR"/tc_$TESTCASE"

DIR_MOUNT="$BASE_DIR/mnt/test_fat32"
MAX_DELETE_FILES=2
FILENAME_TC_ORIGINAL="test_fat32_tc"$TESTCASE"_original.img"
FILENAME_TC="test_fat32_tc"$TESTCASE"_modify.img"
SIZE_CONTAINER=20
fname_sizes="1M"
MAX_DIR=2
MAX_FILES=2
TEST_DIRNAME="test"
TEST_FILENAME="test_file"
TEST_FILE_EXT="dat"
RECOVERY_DIR="recovery"

# ==========================================================================================
# 0 Making container
# making_container $FILENAME_TC_ORIGINAL $DIR_MOUNT $SIZE_CONTAINER
making_container()
{
 echo "#Function: making container"
 mkdir -p $2
 dd if=/dev/zero of=$1 bs=1M count=$3
 mkfs.vfat $1
}

# Mount container
# mount_container $FILENAME_TC_ORIGINAL $DIR_MOUNT
mount_container()
{
# Mount container
 #sudo mount --rw -t vfat -o uid=`users` $FILENAME_TC_ORIGINAL $DIR_MOUNT
 echo "#Function: mount container"
 mkdir -p $DIR_MOUNT
 sudo mount --rw -t vfat -o uid=$cur_user $1 $2
}

# Unmounting container
# umount_container $DIR_MOUNT
umount_container()
{
# UnMount container
 echo "#Function: umount container"
 echo "CUR_DIR:$CUR_DIR"
 cd $CUR_DIR
 sudo umount $1
 echo "Unmount done"
 echo "Remove dir:$1"
 rm -rf $1
}

# Umnounting force
umount_container_force()
{
# Force UnMount container
 echo "#Function: umount force container"
 echo "CUR_DIR:$CUR_DIR"
 cd $CUR_DIR
 sudo umount -f $1
 rm -rf $1
}

#Create files in container
#Create test file with filling from /dev/urandom and calculate md5 sum
create_files_in_container()
{
  MOUNT_FILENAME=`mount|grep $cur_user|grep mnt|awk {'print $1'}|sed 's/.*\///'`
  file_md5="$TESTCASE_DIR/$MOUNT_FILENAME.md5"
  echo "MOUNT_FILENAME: $MOUNT_FILENAME"

  mkdir $DIR_MOUNT/$TEST_DIRNAME
  touch $file_md5

  echo "file_md5: $file_md5"

  for i_dir in `seq 1 $MAX_DIR`
  do
      dr1=$DIR_MOUNT/$TEST_DIRNAME/$TEST_DIRNAME"-"$i_dir
      mkdir -p $dr1
      for i_file in `seq 1 $MAX_FILES`
      do
        fl1=$dr1/$TEST_FILENAME"_"$i_dir"_"$i_file"."$TEST_FILE_EXT
        dd if=/dev/urandom of=$fl1 bs=$fname_sizes count=1 status=none
      done
  done

  cd $DIR_MOUNT
  find . -type f -name "*" -exec md5sum {} \; >$file_md5
  cd $CUR_DIR
}

# 3 Delete some files
# delete_files_in_container $MAX_DELETE_FILES

delete_files_in_container()
{
  echo "#Function: Delete some files"
  echo "cd to directory $DIR_MOUNT"
  cd $DIR_MOUNT ||   { echo "Failure #Function delete_files_in_container "; exit 1; }
  file_will_be_delete=`find . -type f -name "*"| shuf -n $1`
  # file_all=`find . -type f -name "*"`
  for i in $file_will_be_delete
    do
      echo "Delete file:$i"
      rm $i
    done
  cd $CUR_DIR
}

# Create files with name deleted files
create_files_some_names_in_container()
{
  echo "#Function: Create files with name deleted files"
  cd $DIR_MOUNT ||   { echo "Failure #create_files_some_names_in_container "; exit 1; }
  for i in $file_will_be_delete
    do
      echo "Create file:$i"
      dd if=/dev/urandom of=$i bs=$fname_sizes count=1 status=none
    done
  cd $CUR_DIR
}

# Create files with another name
create_files_new_names_in_container()
{
  echo "#Function: Create files with name deleted files"
  cd $DIR_MOUNT ||   { echo "Failure #create_files_some_names_in_container "; exit 1; }
  for i in $file_will_be_delete
    do
      echo "Create file:$i.new"
      dd if=/dev/urandom of="$i.new" bs=$fname_sizes count=1 status=none
    done
  cd $CUR_DIR
}

# formating_container $FILENAME_TC
formating_container()
{
  # 2. Formating container
  echo "#Function: Formating container"
  mkfs.vfat $1
}

# Create and fill container
# create_and_fill_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT
create_and_fill_container()
{
  rm -rf $TESTCASE_DIR
  mkdir -p $TESTCASE_DIR
  mkdir -p $TESTCASE_DIR/$RECOVERY_DIR
#  echo "#0: Making container"
  making_container $1 $2 $SIZE_CONTAINER
#  echo "#0: Mount container"
  mount_container $1 $2
#  echo "#0: Create files in container"
  create_files_in_container
#  echo "#0: UnMount container"
  umount_container $DIR_MOUNT
}

search_mount_container()
{
  MOUNT_FILENAME=`mount|grep $cur_user|grep mnt|awk {'print $1'}|sed 's/.*\///'`
  # echo "Search mount point"
  echo $MOUNT_FILENAME

}