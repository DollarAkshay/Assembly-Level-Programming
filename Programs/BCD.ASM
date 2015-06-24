
;PROGRAM TO PERFORM BCD UP-DOWN COUNTER

.model small
.data
poa dw 0c80ch           ;INITIALISING PORTS
pob dw 0c80dh
poc dw 0c80eh
cw  dw 0c80fh

.code
mov ax,@data            ;INITIALISING DATA SEGMENT
mov ds,ax
mov dx,cw
mov al,80h              ;INITIALISING ALL PORTS TO O/P
out dx,al
mov ax,00h              ;INITIALISE COUNTER TO 00
loop1:mov dx,poa        ;PUT DIPLAY IN PORT A.
     out dx,al
     push ax            ;SAVE COUNTER VALUE IN STACK
     call delay
     mov ah,06h         ;REPEAT UNTIL ENTER A CHARCTER FROM KB.
     mov dl,0ffh
     int 21h
     jnz stop1          ;LOOP UNTIL ANY KEY PRESSED
     pop ax             ;GET BACK COUNTER VALUE FROM STACK
     inc al             ;INCREMENT COUNTER VALUE
     cmp al,0ah         ;COMPARE WITH 0AH TO COUNT 0 TO 9.
     jl loop1           ;IF LESS THAN 0AH REPEAT.
     dec al             ;DECREMENT TO GET 9.
loop2:mov dx,poa        ;DOWN COUNTER
     out dx,al
     push ax
     call delay
     mov ah,06h
     mov dl,0ffh        ;LOOP UNTIL ANY KEY PRESSED
     int 21h
     jnz stop1
     pop ax
     dec al
     cmp al,00h
     jg loop2
     jmp loop1          ;REPEAT THE COUNTER FROM BEGINNING
stop1:mov ah,04ch       ;TERMINATE & EXIT TO DOS
      int 21h
delay proc near         ;PROCEDURE FOR DELAY
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
end                     ;END OF THE PROGARM.


















