        .MODEL SMALL
        .DATA
         N DB 0AH
         A DB 10 DUP(?)

       .CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV CH,00H
        MOV CL,N
        MOV SI,OFFSET A
        MOV BX,00H
        MOV DX,01H
        MOV [SI],BX
        INC SI
        MOV [SI],DX
        DEC CX
        DEC CX
 BEGIN:MOV AX,00H
       ADD AX,BX
       ADD AX,DX
       INC SI
       MOV [SI],AX
       MOV BX,DX
       MOV DX,AX
       LOOP BEGIN
       MOV AH,4CH
       INT 21H
       END

