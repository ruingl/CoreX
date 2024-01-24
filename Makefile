# Makefile

TARGET = kernel
NASM = nasm
XORRISO = xorriso
QEMU = qemu-system-x86_64

$(TARGET).iso: $(TARGET).bin
    $(XORRISO) -as mkisofs -o $@ $<

$(TARGET).bin: $(TARGET).asm
    $(NASM) -f bin -o $@ $<

run: $(TARGET).iso
    $(QEMU) -cdrom $<

clean:
    rm -f $(TARGET).bin $(TARGET).iso