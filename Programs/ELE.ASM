; Drive an elevater interface to move elevator from ground to top floor and 
; top to ground floor.

.model small
.data
	pa dw 0c80ch  	;INITIALISING PORTS
	pb dw 0c80dh
	pc dw 0c80eh
	cw  dw 0c80fh
.code
	mov ax,@data   	;INITIALISING DATA SEGMENT
	mov ds,ax
	mov dx,cw
	mov al,82h		; initialize PORT A and C as output ports and PORT B as input port 
	out dx,al
	mov al,0f0h		; INITALIZE FOR UP MOVEMENT 
	mov dx,pa
	out dx,al
	mov cl,0ah		; 10 STEPS TO MOVE
	mov al,0f0h		; INITALIZE FOR UP MOVEMENT 
	call up		; MOVE ELAVATOR UP
	call clear		; TAKE PERSONS IN TOP FLOOR INTO ELEVATOR
	call delay
	mov al,079h		; INITALIZE FOR DOWN MOVEMENT
	mov cl,0ah
	call down		; MOVE ELAVATOR DOWN
	mov ah,4ch
	int 21h

down proc			; PROCEDURE TO MOVE DOWN
	mov dx,pa
   l1:out dx,al
	call delay
	dec al
	loop l1
	ret
down endp

clear proc			; CLEAR PROCEDURE FOR TAKE IN
	mov dx,pa
	out dx,al
	ret
clear  endp

up  proc		 	; PROCEDURE TO MOVE UP
	mov dx,pa
   l2:out dx,al
	call delay
 	inc al
 	loop l2
 	ret
up endp
  

delay proc near    	;PROCEDURE FOR DELAY
push cx
push bx

mov bx,1ff0h
back2:mov cx,0ffffh
back1:nop
      dec cx
      cmp cx,00h
      jnz back1
      dec bx
      cmp bx,00h
      jnz back2
      pop bx
      pop cx

      ret
delay endp
end


















