 tar ext :3333
 monitor reset
 layout src
 symbol-file
 file kernel.elf
 add-symbol-file apps/apps.bflt.gdb 0x20040 -s .data 0x20009330 -s .bss 0x2000aab4
 mon reset
 mon halt
 stepi
 focus c
