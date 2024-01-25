# Makefile

# Variables
NASM=nasm
GCC=gcc
LD=ld

# Directories
BOOT_DIR=boot
KERNEL_DIR=kernel

# Targets
all: os-image.bin

os-image.bin: $(BOOT_DIR)/mbr.bin $(KERNEL_DIR)/kernel.bin
	cat $^ > $@

$(BOOT_DIR)/mbr.bin: $(BOOT_DIR)/mbr.asm $(BOOT_DIR)/disk.asm $(BOOT_DIR)/gdt.asm $(BOOT_DIR)/switch-to-32bit.asm
	$(NASM) $< -f bin -o $@

$(KERNEL_DIR)/kernel.bin: $(KERNEL_DIR)/kernel-entry.o $(KERNEL_DIR)/kernel.o
	$(LD) -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

$(KERNEL_DIR)/kernel-entry.o: $(KERNEL_DIR)/kernel-entry.asm
	$(NASM) $< -f elf -o $@

$(KERNEL_DIR)/kernel.o: $(KERNEL_DIR)/kernel.c
	$(GCC) -m32 -ffreestanding -c $< -o $@

clean:
	rm -f *.bin *.o $(BOOT_DIR)/*.bin $(KERNEL_DIR)/*.bin