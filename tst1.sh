#!/bin/sh

TESTCASE_N=7
#0x4 - 0x43 FAT0
#0x44 - 0x83 FAT1
COUNT_BYTE_TO_DAMAGE="0x40"
SEEK_TO_DAMAGE="0x44"
. ./tc_function_unit.sh

# ==========================================================================================
# Main
tst1
