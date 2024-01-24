jmp main

main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call dword kernel_main

    hlt

; External declarations
extern kernel_main

; Boot signature
times 510 - ($ - $$) db 0
dw 0xAA55

section .note.GNU-stack, "", @progbits