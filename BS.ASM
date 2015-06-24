.model small
.stack 200
.data
    a db 78h,53h,11h,72h,80h,01h
    len dw $-a
.code
    mov ax,@data
    mov ds,ax
    mov cx,len
    dec cx
 
l1 :
    mov bx,00    
l2 :
    mov al,a[bx]
    cmp al,a[bx+1]
    jb noexch
    mov ah,a[bx+1]
    mov a[bx+1],al
    mov a[bx],ah
noexch :
    inc bx
    cmp bx,cx
    jne l2
    loop l1


    mov ah,4ch
    int 21h

end












