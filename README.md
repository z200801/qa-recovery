# qa-recovery

TestCase shell code making test FAT16 containers for testing some recovery utils.

File tc_function_unit_sh is a shell library with some functions.

TestCase 1 - Standard file deletion.

TestCase 2 - Standard deletion of overwritten files with the same name.

TestCase 3 - Standard deletion of overwritten files with the new name.

TestCase 4 - Standard file deletion with not normal dismounting (force unmount).

TestCase 5 - formating container.

TestCase 6 - damage container (COUNT_BYTE_TO_DAMAGE="0x40", SEEK_TO_DAMAGE="0x44" (#0x44 - 0x83 FAT1)).

