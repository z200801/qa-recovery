#!/bin/sh

# Main library for making testcases scripts

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
SIZE_CONTAINER=100
fname_sizes="2M"
MAX_DIR=4
MAX_FILES=4
TEST_DIRNAME="test"
TEST_FILENAME="test_file"
TEST_FILE_EXT="db"
NEW_EXT="new"
RECOVERY_DIR="win11/recovery"
recovery_dir_array="diskdrill-4.4.607.0 testdisk"
SAMPLES_FILE_ARCH="file_samples.tgz"
container_bs="4k"
# ==========================================================================================
# 0 Making container
# making_container $FILENAME_TC_ORIGINAL $DIR_MOUNT $SIZE_CONTAINER
making_container()
{
 echo "#Function: making container"
 mkdir -p $2
 dd if=/dev/zero of=$1 bs=$container_bs count=$3
 mkfs.vfat -F32 $1
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
  file_md5=$TESTCASE_DIR/$MOUNT_FILENAME".md5"
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

# Copy samples files to container and calculate md5 sum
copy_samples_files_2_container()
{

  MOUNT_FILENAME=`mount|grep $cur_user|grep mnt|awk {'print $1'}|sed 's/.*\///'`
  file_md5=$TESTCASE_DIR/$MOUNT_FILENAME".md5"
  echo "MOUNT_FILENAME: $MOUNT_FILENAME"

  touch $file_md5
  echo "file_md5: $file_md5"

  tar xvf $SAMPLES_FILE_ARCH -C $DIR_MOUNT

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
  # create array with files will be deleted from random (shuf)
  file_will_be_delete=`find . -type f -name "*"| shuf -n $1`
  # logging what a file we deleted
  # write need before deleting and saving information on a image containers
  echo "$file_will_be_delete">$TESTCASE_DIR/$FILENAME_TC"_delete.log"
  md5sum $file_will_be_delete>$TESTCASE_DIR/$FILENAME_TC".deleted_files.md5"
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
      echo "Original name is:$i"
      #echo "New name is:${fln1%%.*}.new"
      pt1=`echo $i|sed 's/\.[^.]*$//'`
      of1=$pt1.$NEW_EXT
      # echo "Create file:$i.new"
      echo "Create file:$of1"
      # dd if=/dev/urandom of="$i.new" bs=$fname_sizes count=1 status=none
       dd if=/dev/urandom of=$of1 bs=$fname_sizes count=1 status=none
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

tst1()
{
  for i in $recovery_dir_array
  do
    echo "i:$i"

  done
}

# Create and fill container
# create_and_fill_container $TESTCASE_DIR/$FILENAME_TC_ORIGINAL $DIR_MOUNT
create_and_fill_container()
{
  rm -rf $TESTCASE_DIR
  mkdir -p $TESTCASE_DIR
  mkdir -p $TESTCASE_DIR/$RECOVERY_DIR
  #making directory for some recovery utils
  for i in $recovery_dir_array
  do
    mkdir -p $TESTCASE_DIR/$RECOVERY_DIR/$i/$RECOVERY_DIR
  done
#  echo "#0: Making container"
  making_container $1 $2 $SIZE_CONTAINER
#  echo "#0: Mount container"
  mount_container $1 $2
#  echo "#0: Create files in container"
  # create_files_in_container
  copy_samples_files_2_container
#  echo "#0: UnMount container"
  umount_container $DIR_MOUNT
}

search_mount_container()
{
  MOUNT_FILENAME=`mount|grep $cur_user|grep mnt|awk {'print $1'}|sed 's/.*\///'`
  # echo "Search mount point"
  #echo $MOUNT_FILENAME
  if [ $MOUNT_FILENAME ]; then
     {
       echo $MOUNT_FILENAME
     }
  fi
}

# Damage conteiner
# damage_container $FILENAME_TC $COUNT_BYTE_TO_DAMAGE $SEEK_TO_DAMAGE
damage_container()
{
  echo "#Function: damage_container"
  #dd if=/dev/urandom of=$1 bs=1 count=$(($COUNT_BYTE_TO_DAMAGE)) seek=$(($SEEK_TO_DAMAGE)) conv=notrunc status=none
  dd if=/dev/urandom of=$1 bs=1 count=$(($2)) seek=$(($3)) conv=notrunc status=none
}

# Compare containers
# compare_containers $FILENAME_ORIGINAL_CONTAINER $FILENAME_TC
compare_containers()
{
  echo "#Function: compare_containers"
  # cmp -b -c $1 $2

  cmp $1 $2 && echo "Identical" || echo "Different"; md5sum $1 $2
}

