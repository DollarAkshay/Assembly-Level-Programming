.model small
.stack 200
.data
    n1 db 05
    n2 db 03
    n3 db ?
.code
    mov ax, @data
    mov ds, ax
    mov al, n1
    mov ah, n2
    add al, ah
    mov n3, al
        int 3
    end

