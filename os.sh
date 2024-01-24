#!/bin/bash

# Ensure that the build directory exists
mkdir -p build

# Compile and Link
nasm -f elf32 Boot.asm -o build/boot.o
gcc -m32 -c src/main.c -o build/main.o
ld -T link.ld -melf_i386 build/boot.o build/main.o -o iso/boot/kernel

# Create ISO
genisoimage -b boot/grub/stage2_eltorito -R -boot-load-size 4 -no-emul-boot -boot-info-table -A Replit iso > os.iso

# Run in Bochs
bochs -q