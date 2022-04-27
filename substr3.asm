DATA SEGMENT
    STR DB 'ABCD$' 
    SUBSTR2 DB 'BF$'
    
    CNT DW 0000H
    LENSUB DB 00H
    LENSTR DB 00H
    POS DB 00H     ;TO STORE INDEX AT WHICH SUBSTR IS FOUND
    MSG1 DB 10,13,'STRING IS:$'
    MSG2 DB 10,13,'SUBSTRING IS:$'
    MSG3 DB 10,13,'SUBSTRING FOUND AT:$'
    MSG4 DB 10,13,'SUBSTRING NOT FOUND$'  
    FOUND DB 00H ;FOUND INCREMENTED TO 1 IF SUBSTR FOUND
DATA ENDS
EXTRA SEGMENT 
      SUBSTR DB 'BF$'
EXTRA ENDS

PRINT MACRO M
    MOV AH,09H
    LEA DX,M
    INT 21H
ENDM

CODE SEGMENT 
    ASSUME CS:CODE,DS:DATA,ES:EXTRA
START:MOV AX,DATA
MOV DS,AX  
MOV AX,EXTRA
MOV ES,AX

    LEA SI,SUBSTR2
LOOP1:MOV AL,[SI]
      CMP AL,'$'
      JE LOOP1END
      INC LENSUB
      INC SI
      JMP LOOP1
LOOP1END:   
LEA SI,STR
LOOP2:MOV AL,[SI]
      CMP AL,'$'
      JE LOOP2END
      INC LENSTR
      INC SI
      JMP LOOP2
LOOP2END:

MOV DL,00H
OUTERLOOP1:LEA SI,STR ;outerloop iterates for the length of the main string 
           ADD SI,CNT
           LEA DI,SUBSTR
           MOV CX,0000H
           MOV CL,LENSUB
           CLD
           REPE CMPSB     ;runs either for the length of the given substring or until its not equal
           JNZ BLOCK1
           MOV POS,DL
           INC FOUND
           JMP FINAL
           
           
           
BLOCK1:  INC CNT
INC DL
CMP DL,LENSTR
       JNZ OUTERLOOP1 
FINAL:CMP FOUND,01H
      JZ FINAL3
      PRINT MSG4
      JMP FINAL2  
FINAL3:PRINT MSG3
FINAL2: MOV AH,4CH
        INT 21H
CODE ENDS
END START
    