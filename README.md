# Simple OS

        mkdir build && cd build

## Boot Sector - Compiling into machine code

        nasm ../boot-sector.asm -f bin -o boot-sector.bin

## Booting with QEMU

        qemu-system-x86_64 boot-sector.bin

## Visualizing the bytes created by the assembler

        od -t x1 -A n boot-sector.bin

## Running the print.asm program

        cd build
        nasm ../print.asm -i ../ -f bin -o print.bin
        qemu-system-x86_64 print.bin
