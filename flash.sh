#!/bin/sh -x

FEL=sunxi-fel

SPLMEMADDR=0x43000000
UBOOTMEMADDR=0x4a000000
UBOOTSCRMEMADDR=0x43100000


$FEL -v spl u-boot-sunxi-with-spl.bin
# wait for DRAM init
sleep 1

$FEL -v write $UBOOTMEMADDR u-boot-dtb.bin || exit 1
$FEL write $UBOOTSCRMEMADDR u-boot-nandinfo.scr || exit 1
$FEL exe $UBOOTSCRMEMADDR || exit 1

sleep 4

[ ! test -f nand-info.bin ] || rm -f nand-info.bin 
$FEL read 0x7c00 0x100 nand-info.bin || exit 1
