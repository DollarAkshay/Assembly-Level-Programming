.model small
.data
	result db ?   ;00 if parity is even else ff
	num db ?     ;number of 1s
	POA DW 0C80CH
	POB dw 0C80DH
	POC DW 0C80EH
	CWR DW 0C80FH	
.code
	mov ax,@data
	mov ds,ax
	mov dx,CWR              ; add of control register
	mov al,82h			; PORT A and C output port and PORT B as input port
	out dx,al             	; initialization of cr
   bk:
	
	mov dx , POB
	in al,dx			; read input from logic controler
	mov bl,00			; initialize no. of ones equal to zero
	mov cx,08h              ; for 8 bit data
   yy:
	rol al,01			; go for next bit
	jnc xx			; if zero skip
	inc bl			; else increment 1's count
   xx:
	loop yy			; repeat for 8 bits
	mov num,bl			; no of ones in i/p
	ror bl,01			; check odd or even
	jc odd			; if odd go to odd
	mov al,0FFH			; else store 0ffh
	mov result,al
	jmp nxt
  odd:mov al,00H		; store 00h
	mov result,al
   nxt:
	mov dx,POA
	mov al,result
	out dx,al
			;mov cx,0ffffh
			;bac1: nop
			;nop
			;nop
			;dec cx
			;jnz bac1
	mov al,00h
	mov ah,06H
	mov dl,0FFH
	INT 21H
	jz bk
	mov dl,num
	add dl,30H
	mov ah,06H
	INT 21H

	mov ah,4CH
	INT 21H
	end
