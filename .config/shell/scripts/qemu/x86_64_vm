#!/bin/bash

# XXX: Maybe I shouldn't have it here as many parameters
#      maybe changed on needs. So use virsh with templates
#      or something alike.
function qemu_x86_64_debug()
{
	local QEMU_BIN="qemu-system-x86_64"
	local KERNEL_LOCATION="$(echo ~)/kernel/linux/arch/x86_64/boot"
	local KERNEL="bzImage"
	local DISK_LOCATION="$(echo ~)/buildroot/buildroot-x86_64/output/images"
	local DISK="rootfs.ext2"
	local CMDLINE="root=/dev/sda rw console=ttyS0 earlyprintk=serial,ttyS0,115200"

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
}
