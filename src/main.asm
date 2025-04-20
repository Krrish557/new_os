org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start: 
    jmp main



; function to print data on the screen
; params:
;   -ds:si pointing to a string (where ds: data segment and si: segment index)

put: 
    push si
    push ax



.loop:
    lodsb
    or al, al
    jz .done

    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret



main: 

    ; data segments
    mov ax, 0
    mov ds, ax ; saves the data (data segment)
    mov es, ax ; extra segment (usually for strings)

    ; stack segments
    mov ss, ax ; stack segement to 0
    mov sp, 0x7C00 ; stack pointer to the begging of our program

    mov si, msg
    call put, 

    hlt
.halt:
    jmp .halt

msg: db "My first working operating system, yay", ENDL, 0

times 510-($-$$) db 0
dw 0AA55h