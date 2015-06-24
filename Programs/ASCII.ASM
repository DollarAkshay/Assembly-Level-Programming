.model small
.stack 200
.data
    m1 db 'Enter a character : $'

.code
    mov ax,@data
    mov ds,ax

    mov ah,00
    mov al,02
    int 10h

    lea dx,m1
    mov ah,09h
    int 21h

    mov ah,01h
	int 21h

    AND ax,00ffh
    mov cl,4
    shl ax,cl
    shr al,cl

    add al,30h
    cmp al,39h
    jle msb
    add al,7h

msb :
    add ah,30h
    cmp ah,39h
    jle disp
    add ah,7h

disp :
    push ax
    mov ah,02h
    mov bh,00
    mov dh,15
    mov dl,35
    int 10h
    pop ax
    mov dl,ah
    push ax
    mov ah,02h
    int 21h

    pop ax
    mov dl,al
    mov ah,02h
    int 21h

    mov ah,4ch
    int 21h
end




