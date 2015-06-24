.model small

.data
	x 	db ?
	y 	db ?
	xy 	dw ?
	mes 	db 10,13,"the product is: $"

	pa DW 0C80CH                   ;initialising ports
	pb DW 0C80DH
	pc DW 0C80EH
	cr DW 0C80FH

.code
        mov ax,@data            ;initialising data segment register.
        mov ds,ax
        mov dx,cr              ;address of control register
        mov al,082h              ;initialization of control register(cr)with
        out dx,al               ;port A o/p and port C i/p.

        mov dx ,pb
        in al,dx			; read input from logic controller
        mov x,al			; store it in x
        mov ah,01h
        int 21h			; wait till enter any key from key board
        mov dx,pb
        in al,dx			; read next input from logic controller
        mov y,al			; store it in y
        mov bl,x
        mul bl			; multiply x and y
        mov xy,ax			; store result in xy

        mov dx,pa
        mov ax,xy			; disply lower byte
        out dx,al

        mov ah,01h		; wait till enter any key from key board
        int 21h

        mov dx,pa
        mov ax,xy
        xchg al,ah		; disply higher byte
        out dx,al 
        mov ah,4CH
        INT 21H
        end


