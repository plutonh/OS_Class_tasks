# Makefile for running CP/M-86 in Qemu
# Written by David Wagner

all:
	@echo "Type 'make help' for a list of commands"

help:
	@echo "make run - Start the CP/M Operating System"
	@echo "make dir - List files on the CP/M disk"
	@echo "make copy file=<filename> - Copy 'filename' to the CP/M disk"
	@echo "               Do not erase the existing file on the CP/M disk"
	@echo "make overwrite file=<filename> - Copy 'filename' to the CP/M disk"
	@echo "               Erase and overwrite the existing file on the CP/M disk"
	@echo "make copyfrom file=<filename> - Copy 'filename' from the CP/M disk'"
	@echo "make copybin file=<filename> - Copy binary file 'filename' to the CP/M disk"
	@echo "make era file=<filename> - Erase 'filename' from the CP/M disk"

dir: ls
copy: cp
copybin: cpbin
copyfrom: cpfrom
era: rm
del: rm

ls: /usr/bin/cpmcp
	cpmls -f cpm86-144feat cpm86os.flp

cp: /usr/bin/dos2unix /usr/bin/cpmcp
	unix2dos -n $(file) cpmQemuDisk/$(file).dos
	cpmcp -f cpm86-144feat cpm86os.flp cpmQemuDisk/$(file).dos 0:$(file)

overwrite: /usr/bin/dos2unix /usr/bin/cpmcp
	unix2dos -n $(file) cpmQemuDisk/$(file).dos
	cpmrm -f cpm86-144feat cpm86os.flp 0:$(file)
	cpmcp -f cpm86-144feat cpm86os.flp cpmQemuDisk/$(file).dos 0:$(file)

cpfrom: /usr/bin/dos2unix /usr/bin/cpmcp
	cpmcp -f cpm86-144feat cpm86os.flp 0:$(file) cpmQemuDisk/$(file).dos
	tr -d '\000' < cpmQemuDisk/$(file).dos > cpmQemuDisk/$(file).nonull
	dos2unix -n cpmQemuDisk/$(file).nonull $(file)

cpbin: /usr/bin/cpmcp
	cpmcp -f cpm86-144feat cpm86os.flp $(file) 0:$(file)

rm: /usr/bin/cpmcp
	cpmrm -f cpm86-144feat cpm86os.flp $(file)

run: cpmQemuDisk/cpm86qemu.flp /usr/bin/qemu-system-x86_64
	qemu-system-x86_64 -no-fd-bootchk -drive file=cpmQemuDisk/cpm86qemu.flp,index=0,if=floppy,format=raw
	./cpmDiskConverter/cpmDiskConverter.x cpmQemuDisk/cpm86qemu.flp cpm86os.flp vmw-to-cpmt
	rm cpmQemuDisk/cpm86qemu.flp

cpmQemuDisk/cpm86qemu.flp: cpm86os.flp cpmDiskConverter/cpmDiskConverter.x
	./cpmDiskConverter/cpmDiskConverter.x cpm86os.flp cpmQemuDisk/cpm86qemu.flp cpmt-to-vmw

cpmDiskConverter/cpmDiskConverter.x: cpmDiskConverter/cpmDiskConverter.c /usr/bin/gcc
	gcc -o cpmDiskConverter/cpmDiskConverter.x cpmDiskConverter/cpmDiskConverter.c

/usr/bin/cpmcp:
	@echo ""
	@echo "Install cpmtools by typing 'sudo apt install cpmtools'"
	@echo ""

/usr/bin/gcc:
	@echo ""
	@echo "Install the gcc compiler by typing 'sudo apt install gcc'"
	@echo ""

/usr/bin/dos2unix:
	@echo ""
	@echo "Install dos2unix by typing 'sudo apt install dos2unix'"
	@echo ""

/usr/bin/qemu-system-x86_64:
	@echo ""
	@echo "Install qemu by typing 'sudo apt install qemu-system-x86'"
	@echo ""



