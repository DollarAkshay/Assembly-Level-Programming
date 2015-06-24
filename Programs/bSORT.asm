 .MODEL SMALL
 .DATA
 ARRAY DB 05,04,03,06,02,01
 N DW $-ARRAY

 .CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV CH,00H
        MOV CL,N
        DEC CL
 AGAIN2:MOV DL,CL
        MOV SI,OFFSET ARRAY
 AGAIN1:MOV AL,[SI]
        CMP AL,[SI+1]
        JG  FRONT
        XCHG AL,[SI+1]
        XCHG [SI],AL
 FRONT: INC SI
        DEC DL
        JNZ AGAIN1
        LOOP AGAIN2
        MOV AH,4CH
        INT 21H
        END
