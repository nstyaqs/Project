.model small
.stack 100h

.data
    array dw 10000 dup (?)
    count dw 0
    buffer db 255 dup (?)         
    newline db 13, 10, '$' 
    average dw ?
    median dw ?
.code
start: 
    mov ax, @data
    mov ds, ax

read_loop:
    mov cx, 1000
    mov si, array
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
 ; bubble sort
    mov cx, count
    dec cx
outer_loop:
    push cx
    lea si, array
inner_loop:
    mov ax, [si]
    cmp ax, [si+2]
    jl next_step
    xchg [si+2], ax
    mov [si], ax
next_step:
    add si, 2
    loop inner_loop
    pop cx
    loop outer_loop

find_average:
    mov ax, count       
    xor dx, dx          
    mov bx, ax          
    mov si, offset array 
    mov cx, ax          
    xor ax, ax          
average_loop:
    add ax, [si]        
    add si, 2           
    loop average_loop   

    div bx              
    mov average, ax  
average_print:
    mov dx, offset average
    mov ah, 09h
    int 21h

find_median:
    mov cx, count
    shr cx, 1  
    jnc even_count  
    mov si, cx  
    shl si, 1
    lea si, array[si]
    mov ax, [si]
    mov median, ax
    jmp median_print
even_count:
    mov si, cx
    shl si, 1
    mov ax, [si]  
    add si, 2
    add ax, [si]
    cwd
    div cx
    mov median, ax

median_print:
    mov dx, offset median
    mov ah, 09h
    int 21h     


    mov ax, 4C00h
    int 21h
end start