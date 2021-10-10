# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers
# Edit by @topser99 for A20
## AnyKernel setup
# begin properties
properties() { '
kernel.string=NevaCore 3.0
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=10-12
'; } # end properties

# shell variables
block=/dev/block/platform/13540000.dwmmc0/by-name/BOOT;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

mount -o rw,remount -t auto /system >/dev/null;

write /sys/devices/battery/ac_charge 2050

#chmod 755 /system/bin/busybox;

umount /system;


write_boot;

ui_print "x Done";
## end install
