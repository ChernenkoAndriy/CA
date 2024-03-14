.model small
.stack 100h
.data
keys dw 10000*8 dup(?)
values dw 10000 dup(?)
oneChar db ?
filename db 'inp.txt', 0
handle dw ?
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
    
    mov oneChar, 32
    jmp read_next      

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
    int 21h            ; Terminate program

end start
