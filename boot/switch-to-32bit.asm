; switch-to-32bit.asm
[bits 16]

section .text
global switch_to_32bit

switch_to_32bit:
    cli                      ; Disable interrupts
    lgdt [gdt_descriptor]    ; Load GDT descriptor
    mov eax, cr0
    or eax, 0x1              ; Enable protected mode
    mov cr0, eax
    jmp CODE_SEG:init_32bit  ; Far jump

[bits 32]

init_32bit:
    mov ax, DATA_SEG         ; Update segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000         ; Setup stack
    mov esp, ebp

    ; Call back to the bootloader
    call BEGIN_32BIT