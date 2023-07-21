# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# Create a list of object files to build, simply by replacing
# the '.c' extension of filenames in C_SOURCES with '.o'
OBJ = ${C_SOURCES:.c=.o}

# Default make target
all: os-image.bin

# Run qemu
run: all
	qemu-system-x86_64 -fda os-image.bin

# Actual disk image that the computer loads which is a combination of the 
# compiled boot sector and kernel
os-image.bin: boot/boot-sect.bin kernel.bin
	cat  $^ > os-image.bin

# Link kernel object files into one binary, making sure the
# entry code is right at the start of the binary.
kernel.bin: kernel/kernel-entry.o ${OBJ}
	ld -o $@ -m elf_i386 -Ttext 0x1000 $^ --oformat binary

# Generic rule for compiling C code to an object file
# For simplicity, where C files depend on all header files
%.o: %.c ${HEADERS}
	gcc -ffreestanding -fno-pie -m32 -c $< -o $@

# Assemble the kernel-entry
%.o: %.asm
	nasm $< -f elf -o $@

boot-sect.bin: boot/boot-sector.asm
	nasm boot/boot-sector.asm -i ./ -f bin -o boot/boot-sect.bin

clean:
	rm -fr *.bin *.o *.dis *.map
	rm -fr kernel/*.o boot/*.bin drivers/*.o

# Disassemble kernel for debugging
kernel.dis: kernel/kernel.bin
	ndisasm -b 32 kernel.bin > kernel.dis
