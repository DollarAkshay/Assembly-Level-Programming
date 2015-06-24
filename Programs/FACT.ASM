.MODEL SMALL
.DATA
  NUM DB 00
  RES DW ?

.CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV AX,01H
        MOV BL,NUM
        CMP BX,01
        JLE STOR
        CALL FACT
STOR :  MOV RES,AX
        MOV CX,00H
        MOV BX,0AH
ABOVE : MOV DX,00H
        DIV BX
        PUSH DX
        INC CX
        CMP AX,00H
        JNZ ABOVE
   NEXT :POP DX
        ADD DL,30H
        MOV AH,02H
        INT 21H
        LOOP NEXT
        MOV AH,4CH
        INT 21H
 FACT PROC NEAR
      CMP BX,01
      JE NXT
      PUSH BX
      DEC BX
      CALL FACT
      POP BX
      MUL BX
      RET
 NXT :MOV AX,01H
      RET
 FACT ENDP
 END
