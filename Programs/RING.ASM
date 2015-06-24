.model small
.data
poa dw 0c80ch  ;INITIALISING PORTS
pob dw 0c80dh
poc dw 0c80eh
cw  dw 0c80fh
.code
mov ax,@data   ;INITIALISING DATA SEGMENT
mov ds,ax
mov dx,cw
mov al,80h      ;INITIALISING ALL PORTS TO O/P
out dx,al
mov ax,01h      ;initialize conter with 00000001
back:mov dx,poa ;put the o/p in port a.
     out dx,al
     push ax    ;save ax in stack
     mov ah,06h ;repeat until enter a character from KB
     mov dl,0ffh
     int 21h
     jnz stop
     call delay
     pop ax          ;get back ax from stack
     rol al,01h      ;rotate counter by one bit left
     jmp back        ;repeat 
stop:mov ah,04ch
     int 21h
delay proc near    ;PROCEDURE FOR DELAY
mov bx,0ff0h
back2:mov cx,0ffffh
back1:nop
      dec cx
      cmp cx,00h
      jnz back1
      dec bx
      cmp bx,00h
      jnz back2
      ret
delay endp
end                ;end of the program.
