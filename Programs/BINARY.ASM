.model small
.stack 200
.data
    ARRAY DB 01H,02H,03H,04H,05H,06H
    len DW $-ARRAY
    KEY DB 05H
    M1 DB "KEY IS FOUND$"
    M2 DB "KEY IS NOT FOUND$"

.code
    MOV AX,@data
    MOV DS,AX

    mov al,key
    mov si,0
    mov di,len
    dec di

search :
    mov bx,si
    add bx,di
    shr bx,1
    cmp al,array[bx]
    je  found
    jg  hi
    jmp lo

hi :
    inc bx
    mov si,bx
    jmp again
lo :
    dec bx
    mov di,bx
    jmp again
again :
    cmp si,di
    jg notfound
    jmp search


found :
    lea dx,m1
    mov ah,09h
    int 21h
    jmp exit

notfound :
    lea dx,m2
    mov ah,09h
    int 21h
    jmp exit

exit :
    mov ah,4ch
    int 21h

end









