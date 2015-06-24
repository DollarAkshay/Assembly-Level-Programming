.model small
.data
bin1    dw 0010h
seg2    db 4 dup(0ffh)
seg1    db 5 dup(03)
        db 4 dup(0ffh)
dtb     db  003h, 0F3h, 025h, 00dh, 099h, 049h, 041h,    
            01fh,001h,019h
msg     db 'Press any key on computer kbd to return to DOS', 13, 
            10, '$'

time1  db  02
pa      equ 0c80ch
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh

 .code
        mov ax, @data      ;INITIALISE DS
        mov ds, ax
        mov al, 80h        ;ALL PORTS ARE O/P.
        mov dx, ctrl
        out dx, al
        lea si,seg1
        add si,04h
        mov ax,bin1
        mov cx,0ah
 rep1:  mov dx,0000h
        div cx
        push ax
        lea di,dtb
        add di,dx
        mov dl,[di]
        mov [si],dl
        dec si
        pop ax
        cmp ax,00h
        jnz rep1
            
above:  mov ch,00
nxtc:   mov al,04
        push cx
        push ax
        add al,ch
        call disp4      
        call delay
        pop ax



        pop cx
        inc ch
        cmp ch,0ah
        jb  nxtc

        mov ch,09h
nxtc1:  mov al,04
        push cx
        push ax
        add al,ch
        call disp4      
        call delay
        pop ax
        pop cx
        dec ch
        cmp ch,00h
        ja  nxtc1
        dec time1
        ja above

quit:   mov ah, 4ch
        int 21h

delay   proc                ; DELAY PROCRDURE 
        push ax
        push cx
        mov aX,09ffh
agn1:   mov cx, 0ffffh
agn:    loop agn
        dec aX
        jnz agn1
        pop cx
        pop ax
        ret
delay   endp                ; END OF PROCEDURE.


disp4 proc                  ; DISPLAY PROCEDURE
        mov si, 04          ; NEXT CHAR COUNT UNTIL ZERO(4 
                            ; CHARACTERS)

nxtchar:mov ah, 08          ; FOR SHIFTING SHIFT REGISTER TAKING SERIAL input
        dec al



        push ax              ;INITIALISE AL FOR XLAT
        lea bx, seg2         ;INITIALISE BX FOR XLAT
        xlat                 ;READ THE CONTENT FROM LOOK UP TABLE to al

nxtseg: mov dx, pb           ;OUPUT BIT BY BIT IN PORT B
        out dx, al
                           
        mov ch, al           ;PRESERVE THE VALUE OF AL
        mov al, 00           ;GIVE CLOCK ZERO(I.E. LOW PULSE IN  
                             ;PORT C)
        mov dx, pc
        out dx, al

        mov al, 0ffh         ;GIVE CLOCK ONE(I.E. HIGH PULSE IN  
                             ;PORT C)
        out dx, al

        dec ah               ;REPEAT FOR 8 BITS.
        jz ovrchk

        mov al, ch           ;GET BACK SEGMENT CODE
        ror al, 01           ;ROTATE FOR NEXT BIT
        jmp nxtseg

ovrchk: dec si
        pop ax               ;FOR NEXT CHARACTER
        cmp si, 00           ;UNTIL 4 CHARACTERS
        ja nxtchar

        ret
disp4   endp                 ;END OF THE PROCEDURE
        end                  ;END OF THE PROGRAM
