#!/bin/bash

# XXX: Maybe I shouldn't have it here as many parameters
#      maybe changed on needs. So use virsh with templates
#      or something alike.
function qemu_aarch64_debug()
{
	local QEMU_BIN="qemu-system-aarch64"
	local KERNEL_LOCATION="$(echo ~)/kernel/linux/arch/arm64/boot"
	local KERNEL="Image"
	local DISK_LOCATION="$(echo ~)/rootfs"
	local DISK="aarch64.ext4"
	local CMDLINE="root=/dev/vda rw console=ttyAMA0"

	$QEMU_BIN -kernel "$KERNEL_LOCATION/$KERNEL"	\
		-hda "$DISK_LOCATION/$DISK"		\
		-append "$CMDLINE"			\
		-boot c					\
		-m 1024					\
		-localtime				\
		-name "debug_vm_aarch64"		\
		-netdev user,id=unet -device virtio-net-device,netdev=unet \
		-nographic				\
		-smp cpus=1				\
		-gdb tcp::1236				\
		-cpu cortex-a57				\
		-machine type=virt			\
		$@
}
