#!/bin/bash

nasm -f elf32 bootloader/bootloader.asm -o build/bootloader.o
gcc -m32 -ffreestanding -c kernel/kernel.c -o build/kernel.o
ld -m elf_i386 -Ttext 0x7c00 build/bootloader.o build/kernel.o -o build/corex_os.elf
objcopy -O binary build/corex_os.elf build/corex_os.img

echo "Build successful"