        .model small
        .data
num db 127,138,149,160,170,181,191,200,209,217,224,231
    db 237,242,246,250,252,253,254,253,252,250,246,242,237,231,224  
    DB 217,209,200,191,181,170,160,149,138
    db 36 dup(127)

msg     db 'Press any key on computer kbd to return to DOS', 13, 10, '$'

pa      equ 0c80ch         ;initialising ports
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh


        .code
        mov ax, @data      ;initialise ds
        mov ds, ax
        
        mov al, 80h        ;all ports are o/p.
        mov dx, ctrl
        out dx, al


        mov ah, 09h
        lea dx, msg
        int 21h
above:  mov ah,06h
        mov dl,0ffh
        int 21h
        jnz ter
        LEA BX,num
        mov al,00h
loop1:
        push ax
        xlat
        mov dx,pa
        out dx,al
        pop ax
        inc al
        cmp al,72
        jb loop1

        jmp above
 
 ter:   mov ah,4ch
        int 21h
        end


