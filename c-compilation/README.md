# On 64-bit systems

## Compiling c file in this section

    gcc -ffreestanding -fno-pie -m32 -c filename.c -o filename.o

## Disassembling object file with objdump

    objdump -d filename.o

## Linking to produce a binary executable

    ld -o filename.bin -m elf_i386 -Ttext 0x0 --oformat binary filename.o

## Disassembly of the binary file

    ndisasm -b 32 filename.bin > filename.dis
