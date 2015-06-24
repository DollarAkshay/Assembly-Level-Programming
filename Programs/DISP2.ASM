        .model small
        .data
dtb     db  071h, 0F3h, 11h, 61h, 091h, 61h, 0E3h, 31H
		; SEVEN  SEGMENT CODE FOR [ FIRE HELP ]
msg     db 'Press any key on computer kbd to return to DOS', 13, 10, '$'

pa      equ 0c80ch
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh


        .code
        mov ax, @data      ;initialise ds
        mov ds, ax
        
        mov al, 80h       ;all ports are o/p.
        mov dx, ctrl
        out dx, al

        mov ah, 09h
        lea dx, msg
        int 21h

again:  mov ah, 06h         ;repeat until enter a character
        mov dl, 0ffh        ;from KB
        int 21h
        jnz quit

        mov al,04       ; to display FIRE give in get form table 
        call disp4      ; in ERIF order
        call delay
                            
        mov al,08       ; HELP to display give PLEH
        call disp4
        call delay
        jmp again

quit:   mov ah, 4ch
        int 21h

delay   proc             ; delay procrdure 
        PUSH AX
        mov aX,05ffh
agn1:   mov cx, 0ffffh
agn:    loop agn
        dec aX
        jnz agn1
        POP AX
        ret
delay   endp               ;end of procedure.


disp4 proc                  ;display procedure
        mov si, 04          ; next char count until zero(4 characters)

nxtchar:mov ah, 08         ; for shifting shift register taking serial input
        dec al
        push ax                   ;initialise al for xlat
        lea bx, dtb    ;initialise bx for xlat
        xlat               ;read the content from look up table to al

nxtseg: mov dx, pb         ;ouput bit by bit in port b
        out dx, al
                           
        mov ch, al         ;preserve the value of al
        mov al, 00         ;give clock zero(i.e. low pulse in port c)
        mov dx, pc
        out dx, al

        mov al, 0ffh       ;give clock one(i.e. high pulse in port c)
        out dx, al

        dec ah             ;repeat for 8 bits.
        jz ovrchk

        mov al, ch         ;get back seg code
        ror al, 01         ;rotate for next bit
        jmp nxtseg

ovrchk: dec si
        pop ax             ;for next character
        cmp si, 00         ;until 4 characters
        ja nxtchar

        ret
disp4   endp            ;end of the procedure
        end              ;end of the program







        end


