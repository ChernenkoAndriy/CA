.model small
.stack 3h

.data
tempChar db 0
keys db 10000*16 dup(0)
num_Values dw 10000 dup(0)
isWord db 1
temp_Key_Ar db 16 dup(0)
key_Temp_Ind dw 0
temp_value db 16 dup(0)
.code
main proc
    mov ax, @data
    mov ds, ax
 

read_next:
    mov ah, 3Fh
    mov bx, 0 
    mov cx, 1  
    mov dx, offset tempChar   
    int 21h   
    push ax
    push bx
    push cx
    push dx
    call work_with_char 
    pop dx
    pop cx
    pop bx
    pop ax
    cmp ax, 0
    jnz read_next
    mov ax, 4C00h
    int 21h

main endp

work_with_char proc
cmp tempChar,0Dh
jnz notCR
cmp isWord,0
jne endProc
mov isWord,1
;code to transform char in number
jmp endProc
notCR:
cmp tempChar,0Ah
jnz notLF
cmp isWord,0
jnz endProc
mov isWord,1
;code to transform char in number
jmp endProc
notLF:
cmp tempChar,20h
jnz notSpace
mov isWord,0
    jmp endProc
notSpace:
    cmp isWord, 0
    jnz itsWord
       lea si, temp_value 
        mov bx, numberInd
        add si, bx
        mov al, tempChar
        mov [si], al
        inc numberInd
          jmp endProc
itsWord:
       

endProc:
    ret
 work_with_char endp

