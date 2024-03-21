.model small
.stack 100h

.data
msg1 db 'Enter your Decimal numbers separated by space (press Enter when done): $'
msg2 db 0ah, 'Binary numbers are: $'

numbers db 255 dup(?)        
binaryNumbers db 255 dup(?)  

.code