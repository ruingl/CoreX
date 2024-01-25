; kernel-entry.asm
[bits 32]

section .text
global _start

_start:
    ; Call the main function in C (kernel.c)
    call main

    ; Infinite loop to prevent the CPU from executing random memory
    cli
    hlt