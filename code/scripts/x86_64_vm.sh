#!/bin/bash

QEMU_BIN="qemu-system-x86_64"
KERNEL_LOCATION="/home/japdoll/kernel/linux/arch/x86_64/boot"
KERNEL="bzImage"
#DISK_LOCATION="/home/japdoll/buildroot/buildroot-x86_64/output/images"
DISK_LOCATION="/tmp"
#DISK="rootfs.ext2"
DISK="rootfs.ext4"
CMDLINE="root=/dev/sda rw console=ttyS0 earlyprintk=serial,ttyS0,115200"

$QEMU_BIN -kernel "$KERNEL_LOCATION/$KERNEL"	\
	-hda "$DISK_LOCATION/$DISK"		\
	-append "$CMDLINE"			\
	-boot c					\
	-m 1024					\
	-localtime				\
	-name "debug_vm_x86"			\
	-net nic -net user			\
	-nographic				\
	-smp cpus=4				\
	-enable-kvm				\
	-gdb tcp::1235				\
	$@
