#!/bin/bash

# Compile and Link
nasm -f elf32 Boot.asm
ld -T link.ld -melf_i386 Boot.o -o iso/boot/kernel

# Create ISO
genisoimage -b boot/grub/stage2_eltorito -R -boot-load-size 4 -no-emul-boot -boot-info-table -A Replit iso > os.iso

bochs -q