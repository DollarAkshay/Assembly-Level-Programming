; SCAN A 8 X 3 KEYPAD FOR KEY CLOSURE AND TO STORE THE CODE OF THE KEY PRESSED IN A
; MEMORY LOCATION TO DISPLAY ON SCREEN 
; ALSO DISPLAY  ROW AND COLUMN NUMBERS OF THE KEY PRESSED

        .model small
        .data
prompt  db 'press any key on the computer kbd to return to DOS',13,10,'$'
msg     db   '  The row number of key pressed   :  '
row      db  ?,13,10
msg2     db  '  The column number of key pressed : '
col      db   ?,13, 10,13,10
msg3     db  '  The key pressed is  : '
keyp     db ? ,10,13,10,13,'$'
ask      db '0123456789.+-*/%cC  '



pa      equ 0c80ch
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh

        .code
        mov ax, @data
        mov ds, ax      ;intialize  ds
        
        mov al, 90h
        mov dx, ctrl     ;  initialize ctrl reg
        out dx, al

        mov ah, 9
        lea dx, prompt
        int 21h

again:  mov ah, 6
        mov dl, 0ffh      ;  repeat until enter a char
        int 21h
        jnz quit

        call scan               ; bh = row no. ah = col no. if di = 1
        cmp di, 0               ; di  flag for key scan
        je again

        add bh, 30h
        mov row, bh              ; conver to asci

        add ah, 30h
        mov col, ah

        lea di, ask
        add di, si         ; get char from ask array
        mov al,[di]        ; i.e.   [ask+[si]]
        mov keyp,al

        mov ah, 09h
        lea dx, msg
        int 21h

        call delay         ; call procedure
        jmp again

quit:   mov ah, 4ch
        int 21h                 ; terminate

scan    proc		 ; scan procedure 	
        mov si, 0        ; key code
        mov di, 0        ; flag
        mov cx, 3        ; max row
        mov bh, 0        ; row count
        mov al, 80h

nxtrow: rol al, 1        ; set row one by one
        mov bl, al       ; preseve al

        mov dx, pc
        out dx, al       ; out al in pc

        mov dx, pa
        in al, dx        ; scan i/p
        cmp al, 0
        jnz keyid        ; any key in that row go for column check

        mov al, bl       ; get back
        inc bh           ; increment row count
        add si,08h       ; char count +=8
        loop nxtrow      ; go for next row
        ret

keyid:  mov di, 1        ; set flag
        mov cx, 8        ; max column
        mov ah, 0        ; initalize col count=0

agn2:   ror al, 1        ; check column one by one
        jc skip          ; if set stop
        inc si           ; else increment key code
        inc ah           ;  increment column no.
        loop agn2        ; repete

skip:   ret
scan    endp		; end of scan procedure


delay proc near		; Delay procedure
        push ax
        push cx

        mov ax,02ffh
here1:  mov cx, 0ffffh
here:   nop
        nop
        nop
        loop here
        dec ax
        jnz here1
    pop cx
    pop ax
ret
delay endp			; End of delay procedure


        end







        


