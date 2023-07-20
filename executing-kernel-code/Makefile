# Default make target
all: os-image.bin

# Run qemu
run: all
	qemu-system-x86_64 -fda os-image.bin

# Actual disk image that the computer loads which is a combination of the 
# compiled boot sector and kernel
os-image.bin: boot-sect.bin kernel.bin
	cat boot-sect.bin kernel.bin > os-image.bin

# Build the kernel binary
kernel.bin: kernel-entry.o kernel.o
	ld -o kernel.bin -m elf_i386 -Ttext 0x1000 kernel-entry.o kernel.o --oformat binary

# Build the kernel entry object file
kernel-entry.o: kernel-entry.asm
	nasm kernel-entry.asm -f elf -o kernel-entry.o

# Build the kernel object file
kernel.o: kernel.c
	gcc -ffreestanding -fno-pie -m32 -c kernel.c -o kernel.o

boot-sect.bin: boot-sector.asm
	nasm boot-sector.asm -i ../ -f bin -o boot-sect.bin

clean:
	rm -fr *.bin *.o *.dis *.map

# Disassemble kernel for debugging
kernel.dis: kernel.bin
	ndisasm -b 32 kernel.bin > kernel.dis
