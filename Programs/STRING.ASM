.model small
.data
   msg  db "enter any string.$"
   lin db 10,13,"$"

   str1 db 25,?,100 dup('$')
.code
   mov ax,@data
   mov ds,ax

   lea dx,msg
   
   mov ah,09h
   int 21h

   lea dx,str1
   mov ah,0ah
   int 21h

   lea dx,lin
   mov ah,09h
   int 21h
    lea dx,str1+2
    mov ah,09h
    int 21h
   mov ah,4ch
   int 21h
 end

