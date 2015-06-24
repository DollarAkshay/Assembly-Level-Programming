.model small
.stack 200
.data
    n dw 10
.code
    mov ax,@data
    mov ds,ax
    mov bl,245
    mov dx,n
    mov cx,80

for  :
    dec bl
    mov dl,bl
    mov cx,80
for1 : mov ah,02
      int 21h
      loop for1
    inc bl
    mov dl,bl
    mov cx,80
    mov ah,03
    int 10
for2 : mov ah,02
      int 21h
      loop for2
     dec dx
     mov cx,dx
     loop for

    mov ah,4ch
    int 21h
end
