.model small
.stack 3h

.data
keys db 10000*16 dup(0)
key_Times dw 5500 dup(0)
num_Values dw 10000 dup(0)
tempChar db 0
presInd dw 0
newInd dw 0
temp_Key_Ar db 16 dup(0)
key_Temp_Ind dw 0
isWord db 1
temp_value db 16 dup(0)
numberInd dw 0
filename  db "inp.txt"
handle dw 0


.code
main proc
 mov ax, @data
    mov ds, ax

    lea dx, fileName
    mov ah, 03Dh 
    mov  al, 0
    int 21h
    mov [handle] , ax

read_next:
    mov ah, 3Fh
    mov bx, [handle]
    mov cx, 1  
    lea dx, tempChar   
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
    lea si, temp_value 
    dec numberInd
    add si, numberInd
    mov [si],0
    call char_to_number
    mov ax, 4C00h
    int 21h

main endp


work_with_char proc
cmp tempChar,0Dh
jnz notCR
cmp isWord,0
jne endProc
mov isWord,1
call char_to_number
jmp endProc
notCR:
cmp tempChar,0Ah
jnz notLF
cmp isWord,0
jnz endProc
mov isWord,1
call char_to_number
jmp endProc
notLF:
cmp tempChar,20h
jnz notSpace
mov isWord,0
call work_with_key
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
lea si, temp_Key_Ar
mov bx, key_Temp_Ind 
add si, bx
mov al, tempChar
mov [si], al
inc key_Temp_Ind 
endProc:
ret
work_with_char endp 
char_to_number PROC
mov bx, 0
mov cx, 0

calcNum:
    lea si, temp_value 
    add si, numberInd
    dec si
    sub si, cx
    mov ax, 0
    mov al, [si]
    cmp ax, 45
    jnz notMinus
    neg bx
    jmp afterCalc

notMinus:        
    sub al, '0'
    push cx
    cmp cx, 0
    jnz notZer
    jmp endOFMul

notZer:
    mulByTen:
    mov dx, 10
    mul dx
    loop mulByTen

endOFMul:    
    pop cx
    add bx, ax
    inc cx
    cmp cx, numberInd
    jnz calcNum

afterCalc:    
    lea si, num_Values
    mov ax, presInd
    shl ax, 1  
    add si, ax
    add bx, [si]
    mov [si], bx
    mov numberInd, 0
    mov cx, 0

fillZeros:
    lea si, temp_value 
    add si, cx
    mov [si], 0
    inc cx
    cmp cx, 9
    jnz fillZeros

ret

char_to_number endp

work_with_key proc
work_with_key endp
end main