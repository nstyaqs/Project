.model small
.stack 100h

.data
    array dw 10000 dup (?)
    count dw 0
.code
start: 
    mov ax, @data
    mov ds, ax

read_loop:

    mov ah, 0Ah
    mov dx, offset buffer
    int 21h

    cmp buffer[1], 1Bh
    je end_read

    lea si, buffer+2
    mov cx, 0

end start