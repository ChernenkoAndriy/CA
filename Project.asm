.model small
.stack 100h
.data
keys db 10000*16 dup(?)
values db 10000*16 dup(?)
curWord db 16 dup('$') 
oneChar db ?
filename db 'inp.txt', 0
handle dw ?
сurkey db 0
curnum db 0
.code
start:
    mov ax, @data
    mov ds, ax   
    
    ; Open the file for reading
    mov ah, 3Dh        ; Function to open file
    lea dx, filename   ; Load filename
    mov al, 0          ; Read-only mode
    int 21h            ; AX will contain file handle
    mov handle, ax     ; Save file handle
    
read_next:
    ; Read from file
    mov oneChar, 32
    mov ah, 3Fh        ; Function to read from file
    mov bx, handle     ; File handle
    mov cx, 1          ; Number of bytes to read
    lea dx, oneChar    ; Pointer to buffer
    int 21h
    push ax
    mov ah, 02h
    push dx
    mov dl, oneChar
    int 21h        
    pop dx     ; Read from file 
    pop ax     ; Check for errors
    cmp ax, 0          ; Check if end of file
    je end_of_file     ; Jump if end of file reached
    
    jmp write_char
          

display_char:
    push ax
    mov ah, 02h
    push dx
    mov dl, oneChar
    int 21h        
    pop dx     
    pop ax
    
end_of_file:
    mov ah, 01h
    int 21h
    ; Handle end of file here
    jmp exit_program

exit_program:
    mov ah, 4Ch        ; Function to terminate program
    int 21h 
    
write_char:
push ax
push si
push cx
push di
cmp oneChar,  32
je writekey
cmp oneChar,  'a'
je writeNum
mov si, offset curWord ; Завантажуємо адресу початку масиву curWord у SI
    mov cx, 16             ; CX = довжина масиву curWord
search_free_space:
    lodsb                 ; Завантажуємо наступний символ з масиву curWord в AL
    cmp al, '$'           ; Перевіряємо, чи це кінець рядка
    je found_space        ; Якщо так, ми знайшли вільне місце
    loop search_free_space ; Якщо ні, продовжуємо пошук
    jmp end_of_file       ; Якщо не знайдено вільного місця, просто завершуємо функцію

found_space:
    dec si                  ; Повертаємося назад, щоб записати символ на вільне місце
    mov al, oneChar        ; Завантажуємо значення oneChar у AL
    mov [si], al           ; Записуємо AL у вільне місце
    jmp read_next          ; Переходимо до наступного символу з файлу
pop di
pop cx
pop si
pop ax
jmp read_next

writekey:
push ax
push bx
push cx
push dx
mov ah, [curkey]
lea dx, keys
mov cx,  0
pop dx 
pop cx
pop bx
pop ax


writenum:



end start
