; main.asm

extern main

section .text
global _start

_start:
    ; Your existing bootloader code goes here

    ; Call the main function from C
    call main

    ; Infinite loop
    jmp $