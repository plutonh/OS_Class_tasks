all:
	@echo "Type 'make run' or 'make dir' or 'make copy file=<filename>'"
	@echo "or 'make copyfrom file=<filename>' or 'make del file=<filename>'"

dir: ls
copy: cp
copyfrom: cpfrom
era: rm

ls:
	cpmls -f cpm86-144feat cpm86os.flp

cp:
	cpmcp -f cpm86-144feat cpm86os.flp $(file) 0:$(file)

cpfrom:
	cpmcp -f cpm86-144feat cpm86os.flp 0:$(file) $(file)

rm:
	cpmrm -f cpm86-144feat cpm86os.flp $(file)

run: cpmQemuDisk/cpm86qemu.flp
	qemu-system-x86_64 -no-fd-bootchk -drive file=cpmQemuDisk/cpm86qemu.flp,index=0,if=floppy,format=raw
	./cpmDiskConverter/cpmDiskConverter.x cpmQemuDisk/cpm86qemu.flp cpm86os.flp vmw-to-cpmt
	rm cpmQemuDisk/cpm86qemu.flp

cpmQemuDisk/cpm86qemu.flp: cpm86os.flp cpmDiskConverter/cpmDiskConverter.x
	./cpmDiskConverter/cpmDiskConverter.x cpm86os.flp cpmQemuDisk/cpm86qemu.flp cpmt-to-vmw

cpmDiskConverter/cpmDiskConverter.x: cpmDiskConverter/cpmDiskConverter.c
	g++ -o cpmDiskConverter/cpmDiskConverter.x cpmDiskConverter/cpmDiskConverter.c


