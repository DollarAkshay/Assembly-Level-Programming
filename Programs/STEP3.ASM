.model small
.data
 pa equ 0c80ch
 pb equ 0c80dh
 pc equ 0c80eh
 cr equ 0c80fh

.code

    mov ax , @data  ;initialize ds
    mov ds , ax

    mov al , 80h   ; initialize cwr
    mov dx , cr     ; with all ports as o/p
    out dx , al

    mov cx , 400   ;count for rotation 
    mov al , 33h   ;initalize with 00110011 for rotation
    mov dx , pc    ; o/p port

bk:
    out dx , al   ; for one step rotation
    rol al , 01   ;anticlockwise
    call delay    ; wait for delay
    loop bk       ; repeat


    mov ah , 4ch
    int 21h

 delay proc near   ; procedure for delay

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
delay endp      ; end of procedure delay


end            ; end of program
