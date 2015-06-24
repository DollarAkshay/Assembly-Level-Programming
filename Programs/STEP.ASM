;PROGRAM TO ROTATE STEPPER MOTOR IN ANTICLOCKWISE AND ANTICLOCKWISE DIRECTION BY N STEPS
; N=100 IN THIS PROGRAM TO ROTATE 180 DEGREE


.model small
.data
 pa equ 0c80ch	; PORT ADDRESSES OF 8255
 pb equ 0c80dh
 pc equ 0c80eh
 cr equ 0c80fh

.code

    mov ax , @data
    mov ds , ax		;INITIALIZE DS

    mov al , 80h		; INITIALIZE ALL PORTS AS OUTPUT PORT 	
    mov dx , cr		; IN MODE 0
    out dx , al
bbk:
    mov cx , 100		;COUNT TO ROTATION FOR 180 DEGREE
    mov al , 33h		;00110011 INITIALIZATION FOR ROTATION
    mov dx , pc

bk:
    out dx , al
    rol al , 01		; FOR ANTICLOCKWISE
    call delay		; TO MAP SPEED OF M/C WITH MOTOR
    loop bk			; REPEAT FOR NEXT STEP

   
    mov cx ,100 		;COUNT TO ROTATION FOR 180 DEGREE

    mov dx , pc
bk1:
    out dx , al
    ror al , 01		; FOR CLOCKWISE DIRECTION

    call delay
    loop bk1		; REPEAT FOR NEXT STEP

    mov ah , 06h		; SCAN KEYBORD TO TERMINATE
    mov dl , 0ffh		; IF NOTHING IS ENTERED GO BACK TO LOOP
    int 21h			;  ELSE TERMINATE
    jz bbk



    mov ah , 4ch		;TERMINATION CONTROL RETURN TO DOS INTERRUPT
    int 21h

 delay proc near   ; PROCEDURE FOR DELAY

     push cx
     push bx
     mov bx , 050h
 back:
     mov cx , 0ffffh
 here:
     loop here
     dec bx
     jnz back

     pop bx
     pop cx
     ret
delay endp      	;END OF DELAY PROCEDURE
end  			;END OF PROGRAM
