        .model small
        .data
dtb     db  030H,0FFH,10H,0FFH,63H,03H,0E3H,0E3H,61H,41H,61H,0FFH
	;SEVEN SEGMENT CODE FOR  [ P. A. COLLEGE ]
				

msg     db 'Press any key on computer kbd to return to DOS', 13, 10, '$'

pa      equ 0c80ch
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh


        .code
        mov ax, @data           ;initialise ds
        mov ds, ax
        
        mov al, 80h             ;all ports are o/p.
        mov dx, ctrl
        out dx, al
                                
        mov ah, 09h             ; display msg
        lea dx, msg
        int 21h


above:  mov ch,00		; START FROM  FIRST
nxtc:   mov al,04		; TILL 4 CHARACTER
        push cx
        push ax
        add al,ch    	; START FROM LAST CHARACTER FOR SERIAL IN
        call disp4      ; DISPLAY 4 CHARACTER AT ONCE
        call delay	; DELAY TO STAY DISPLAYING FOR 1-2 SECONDS

        mov ah, 06h         ;repeat until enter a character
        mov dl, 0ffh        ;from KB
        int 21h
        jnz quit

        pop ax
        pop cx
        inc ch		; GO FOR NEXT SET OF 4 CHARACTER
        cmp ch,09h
        jb  nxtc
                            
        jmp above

quit:   mov ah, 4ch
        int 21h

delay   proc             ; delay procrdure 
        push ax
        push cx
        mov ax,09ffh
agn1:   mov cx, 0ffffh
agn:    loop agn
        dec aX
        jnz agn1
        pop cx
        pop ax
        ret
delay   endp                    ;end of procedure.


disp4 proc                      ;display procedure
        mov si, 04              ; next char count until zero(4 characters)

nxtchar:mov ah, 08              ; for shifting shift register taking serial input
        dec al
        push ax                 ;initialise al for xlat
        lea bx, dtb             ;initialise bx for xlat
        xlat                    ;read the content from look up table to al

nxtseg: mov dx, pb              ;ouput bit by bit in port b
        out dx, al
                           
        mov ch, al              ;preserve the value of al
        mov al, 00              ;give clock zero(i.e. low pulse in port c)
        mov dx, pc
        out dx, al

        mov al, 0ffh            ;give clock one(i.e. high pulse in port c)
        out dx, al

        dec ah                  ;repeat for 8 bits.
        jz ovrchk

        mov al, ch              ;get back seg code
        ror al, 01              ;rotate for next bit
        jmp nxtseg

ovrchk: dec si
        pop ax                  ;for next character
        cmp si, 00              ;until 4 characters
        ja nxtchar

        ret
disp4   endp                    ;end of the procedure
        end                     ;end of the program
         
      


