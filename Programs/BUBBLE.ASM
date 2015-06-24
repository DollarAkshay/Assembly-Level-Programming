ASSUME CS:CODE,DS:DATA
DATA SEGMENT
        A DB 07H,04H,01H
        N1 DB N1-A
        B DB 08H,04H,03H
        N2 DB N2-B
DATA ENDS

CODE SEGMENT
START:  MOV AX,DATA
        MOV DS,AX
        MOV CH,00H
        MOV CL,N1
        DEC CL
AGAIN2: MOV DL,CL
        MOV SI,OFFSET A
AGAIN1: MOV AL,[SI]
        CMP AL,[SI+1]
        JL FRONT
        XCHG AL,[SI+1]
        XCHG [SI],AL
FRONT:  INC SI
        DEC DL
        JNZ AGAIN1
        LOOP AGAIN2
        MOV CH,00H
        MOV CL,N2
        DEC CL
AGAIN4: MOV DL,CL
        MOV SI,OFFSET B
AGAIN3: MOV AL,[SI]
        CMP AL,[SI+1]
        JG FRONT1
        XCHG AL,[SI+1]
        XCHG [SI],AL
FRONT1: INC SI
        DEC DL
        JNZ AGAIN3
        LOOP AGAIN4
        MOV AH,4CH
        INT 21H
 CODE ENDS
 END START


