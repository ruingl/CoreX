global entry

MAGIC equ 0x1BADB002
FLAGS equ 0
SUM equ -MAGIC

section .text
align 4
    dd MAGIC
    dd FLAGS
    dd SUM

entry:
    jmp entry