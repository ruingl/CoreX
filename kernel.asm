; kernel.asm

section .text
    global _start

_start:
    ; Set up registers for BIOS teletype output
    mov ah, 0x0e ; BIOS teletype output
    mov al, 'H'
    int 0x10

    mov al, 'e'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, ','
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 'W'
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, 'r'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'd'
    int 0x10

    mov al, '!'
    int 0x10

    ; Infinite loop
    jmp $

section .bss
    resb 510 - ($ - $$) ; Fill the rest of the sector with zeros
    dw 0xaa55 ; Boot signature