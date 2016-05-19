#!/bin/bash

QEMU_BIN="qemu-system-aarch64"
KERNEL_LOCATION="$(echo ~)/kernel/linux/arch/arm64/boot"
KERNEL="Image"
DISK_LOCATION="$(echo ~)/rootfs"
DISK="aarch64.ext4"
CMDLINE="root=/dev/vda rw console=ttyAMA0"

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
