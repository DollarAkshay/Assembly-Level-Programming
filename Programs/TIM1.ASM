ASSUME CS:CODE,DS:DATA
DATA SEGMENT
        MSG DB "TIME IS:"
        VAL DB "  :  :  $"
DATA ENDS
DES MACRO
        AAM
        ADD AX,3030H
        MOV VAL[SI],AH
        INC SI
        MOV VAL[SI],AL
        ADD SI,2
ENDM
CODE SEGMENT
START:MOV AX,DATA
        MOV DS,AX
        MOV AH,2CH
        INT 21H
        MOV SI,0
        MOV AL,CH
        DES
        MOV AL,CL
        DES
        MOV AL,DH
        DES
        MOV AH,9
        LEA DX,MSG
        INT 21H
        MOV AH,4CH
        INT 21H
CODE ENDS
END START
