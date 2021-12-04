#!/bin/sh

TESTCASE=3
#. ./tc_function_unit.sh

md5_dir=$CUR_DIR/"md5"
md5_recovery_file="$CUR_DIR/recovery_files.md5"
md5_deleted_files_log="$CUR_DIR/test_fat32_tc"$TESTCASE"_modify.img_delete.log"
md5_original="$CUR_DIR/test_fat32_tc"$TESTCASE"_original.img.md5"
md5_deleted_files="$CUR_DIR/test_fat32_tc"$TESTCASE"_modify.img.deleted_files.md5"

fname_md5="$CUR_DIR/recovery_files.md5"
CUR_DIR=`pwd`
RECOVERY_DIR="$CUR_DIR/recovery"
#Search files in recovery directory and create md5 sum

echo "RECOVERY_DIR: $RECOVERY_DIR"

cd $RECOVERY_DIR
find . -type f -name "*" -exec md5sum {} \; >$fname_md5

# echo "cd to:$md5_dir"
# cd $md5_dir

files_2_compare=`cat $md5_deleted_files_log`
for i_file in $files_2_compare
  do
    # echo "i_file:$i_file"
    file_name_to_compare=`echo $i_file|sed 's/.*\///'`
    md5_original_file=`grep "$i_file" $md5_deleted_files|awk '{print $1}'`
    echo "file_name_to_compare:$file_name_to_compare"
    echo "md5_original_file:$md5_original_file"
    md5_recovered_file=`grep $file_name_to_compare $md5_recovery_file|awk {'print $1'}`
    echo "md5_recovered_file:$md5_recovered_file"
    if [ md5_original_file != md5_recovered_file ]; then
      echo "md5 different"
      else  echo "md5 is matched"
    fi
  done
