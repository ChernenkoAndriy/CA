.model small
.data
    oneChar dw "Enter a string" 
.code
read_next:
    mov ah, 3Fh
    mov bx, 0h  ; stdin handle
    mov cx, 1   ; 1 byte to read
    mov dx, oneChar   ; read to ds:dx 
    int 21h   ;  ax = number of bytes read
    ; do something with [oneChar]
    or ax,ax
    jnz read_next

end main