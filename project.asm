.model small
.stack 100h

.data
    array dw 10000 dup (?)
    count dw 0
.code
start: 
    mov ax, @data
    mov ds, ax

end start