         .model small
        .data
prompt    db 'press  num op  num in key pad',13,10,'$'
num1      db   ?,' '
chr       db   ?,' ' 
num2      db   ?,' = '
res       dw   ?
mes       db  10,13,10,13,'$'
ask      db '0123456789.+-*/%cC  '



pa      equ 0c80ch
pb      equ 0c80dh
pc      equ 0c80eh
ctrl    equ 0c80fh

        .code
        mov ax, @data
        mov ds, ax
        
        mov al, 90h
        mov dx, ctrl
        out dx, al

        mov ah, 9
        lea dx, prompt
        int 21h

        call scan
        push si
        mov cx,si
        mov bl,cl
        add bl,30h
        mov num1,bl
        call scan
        cmp si,0Bh
        je ad1
        mov byte ptr chr,'-'
        call scan
        pop cx
        sub cx,si
        mov al,cl

  do1:
        mov dx,si
        add dl,30h
        mov num2,dl
        aam
        add ax,3030h
        xchg ah,al
        mov res,ax
        mov ah, 09h
        lea dx, num1
        int 21h
quit:   mov ah, 4ch
        int 21h

ad1:    mov byte ptr chr,'+'
        call scan
        pop cx
        add cx,si
        mov al,cl
        jmp do1


scan    proc
        push cx
        push bx
        mov bx ,0200h
  ll2:      mov cx ,0ffffh
  ll1:      nop
            dec cx
            jnz ll1
            dec bx
            jnz ll2
        pop bx
        pop cx

        mov al, 0ffh
        mov dx, pc
        out dx, al
        mov dx, pa
 above: in  al, dx
        cmp al, 00h
        jne above


    ab1:  in  al, dx
        cmp al, 00h
        jz ab1


        mov si, 0
        mov di, 0
        mov cx, 3
        mov al, 80h

nxtrow: rol al, 1
        mov bl, al

        mov dx, pc
        out dx, al

        sub dx, 2
        in al, dx
        cmp al, 0
        jnz keyid

        mov al, bl
        add si,08h
        loop nxtrow
        ret

keyid:  mov di, 1
        mov cx, 8

agn2:   ror al, 1
        jc skip
        inc si
        loop agn2

skip:   ret
scan    endp
        end







        


