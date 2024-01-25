; mbr.asm
[bits 16]

section .text
    global _start

_start:
    ; Setup stack
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0xffff

    ; Load the kernel
    mov bx, KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load

    ; Switch to 32-bit protected mode
    call switch_to_32bit

    ; Jump to the kernel
    jmp $

%include "disk.asm"
%include "gdt.asm"
%include "switch-to-32bit.asm"

[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

; Variables
BOOT_DRIVE db 0

; Padding
times 510 - ($-$$) db 0
dw 0xaa55