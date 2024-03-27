.model small
.stack 100h

.data
    array dw 10000 dup (?)
    count dw 0
    buffer db 255 dup (?)  
    oneChar db ?           
    newline db 13, 10, '$' 
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
parse_loop:
    cmp byte ptr [si], 0
    je end_of_line

    mov al, [si]
    cmp al, '-'
    je negative
    cmp al, '0'
    jl skip_char
    cmp al, '9'
    jg skip_char  
    inc cx
    jmp continue

negative:
    inc si
    jmp parse_loop

continue:
    inc si
    jmp parse_loop

skip_char:
    inc si
    loop parse_loop
    jmp read_loop

end_of_line:
    add count, cx
    jmp read_loop

end_read:
    

end start