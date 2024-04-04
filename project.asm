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
   call read_loop
   test ax, ax
   jz end_read

   test ax, 8000h
   jnz negative

   mov [si], ax
   add si, 2
   inc word [count]
   loop parse_loop

end_read:
   ret

negative:
   neg ax
   add ax, 1
   mov [si], ax
   add si, 2
   inc word [count]
   loop parse_loop

convert_to_binary:
    mov cx, [count]         
    mov si, array           
convert_loop:
    mov ax, [si]           
    mov bx, ax              
binary_conversion_loop:
    shr ax, 1               
    jc set_bit              
    and bx, 0FFFEh          
    jmp check_loop_end      

set_bit:
    or bx, 1                
check_loop_end:
    test ax, ax             
    jnz binary_conversion_loop  
    mov [si], bx            
    add si, 2               
    loop convert_loop       
    ret

bubble_sort:
    mov cx, [count]
    dec cx
outer_loop:
    mov si, array
inner_loop:
    mov ax, [si]
    cmp ax, [si+2]
    jl next_step
    xchg [si+2], ax
    mov [si], ax
next_step:
    add si, 2
    loop inner_loop
    loop outer_loop
    ret

find_average:
    xor ax, ax       
    xor dx, dx          
    mov cx, [count]          
    mov si, array          
average_loop:
    add ax, [si]        
    add si, 2           
    loop average_loop   

    div cx              
    mov [average], ax  
    ret

find_median:
    mov cx, [count]
    shr cx, 1  
    jnc even_count  
    mov si, cx  
    shl si, 1
    lea si, array[si]
    mov ax, [si]
    mov [median], ax
    ret
even_count:
    mov si, cx
    shl si, 1
    mov ax, [si]  
    add si, 2
    add ax, [si]
    cwd
    div cx
    mov [median], ax
    ret

print_results:
    mov ax, [average]
    call print_word

    mov ax, [median]
    call print_word
    ret
print_word:
    mov cx, 10
    mov bx, ax
    xor dx, dx
    mov si, offset newline +5+1
convert_loop:
    xor dx, dx
    div cx
    add dl, '0'
    dec si
    mov [si], dl
    test bx, bx
    jnz convert_loop
print_dec_num:
    mov dx, si
    mov ah, 09h
    int 21h
    ret


    mov ax, 4C00h
    int 21h
end start