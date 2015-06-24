        .model small
        .data
num db 127,138,149,160,170,181,191,200,209,217,224,231
    db 237,242,246,250,252,253,254,253,252,250,246,242,237,231,224  
    DB 217,209,200,191,181,170,160,149,138

                                        
msg     db 'Press any key on computer kbd to return to DOS', 13, 10, '$'

pa      equ 0c80ch    ;Initialising ports
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh


        .code
        mov ax, @data      ;initialise ds
        mov ds, ax
        
        mov al, 80h       ;all ports are o/p.
        mov dx, ctrl
        out dx, al


        mov ah, 09h       ;Display msg
        lea dx, msg
        int 21h

above:  mov ah,06h        ; Repeat until any key is pressed from the KB
        mov dl,0ffh
        int 21h
        jnz ter

        LEA BX,num        ; base of lookup table
        mov al,00h        ; displacement in the table
loop1:
        push ax           ; preserve the value in stack
        xlat              ; al <-- [ bx +al ]
        mov dx,pa
        out dx,al         ; give o/p to C.R.O
                 
        mov cx,200h       ;Give some delay
 nxt:   nop
        loop nxt


        pop ax            ; get back al i.e. displacement
        inc al           
        cmp al,36         ; repeat for all entries in lookup table
        jb loop1
        jmp above         ;repeat
 
 ter:   mov ah,4ch        ;DOS termination
        int 21h
        end               ;End of the program


