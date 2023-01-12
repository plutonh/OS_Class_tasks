# Makefile for assembling and running WagnerOS in Qemu
# Written by David Wagner

all:
	@echo "Type 'make help' for a list of commands"

help:
	@echo "make run dir=<dirname> - build and run the os"
	@echo "make flp dir=<dirname> - create floppy disk file"
	@echo "make iso dir=<dirname> - create cd-rom iso file"

run: kernel
flp: wagneros.flp
iso: wagneros.iso


kernel: wagneros.flp
	qemu-system-i386 -drive format=raw,file=wagneros.flp
	rm wagneros.flp

wagneros.iso: wagneros.flp
	genisoimage -V 'WAGNEROS' -input-charset iso8859-1 -o wagneros.iso -b wagneros.flp .

wagneros.flp: bootload.bin kernel.bin
	mkdosfs -C wagneros.flp 1440
	dd status=noxfer conv=notrunc if=bootload.bin of=wagneros.flp
	mkdir kernelflp
	sudo mount -t vfat -o loop,defaults wagneros.flp kernelflp/
	sudo cp kernel.bin ./kernelflp
	sudo ls -l kernelflp
	sudo umount kernelflp
	rmdir kernelflp
	rm bootload.bin kernel.bin

kernel.bin: $(dir)/kernel.asm 
	cd $(dir); nasm -fbin kernel.asm -o ../kernel.bin

bootload.bin: $(dir)/bootload.asm
	cd $(dir); nasm -fbin bootload.asm -o ../bootload.bin

clean:
	rm -f *.bin *.flp *.iso

