DATA SEGMENT
    ARR DB 07H, 12H, 23H, 19H, 03H   
    SMALLEST DB ?
    LARGEST DB ?
DATA ENDS  
           
           

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA   
    START:
    MOV AX,DATA 
    MOV DS,AX
     
    MOV CX,04H     ;FIRST ELEMENT IS ALREADY ASSIGNED
    LEA SI,ARR
    MOV BL,[SI]    ;CONTAINS CURRENT SMALLEST
    MOV BH,[SI]    ;CONTAINS CURRENT LARGEST
    INC SI 
    
    LP:
    MOV AL,[SI]     
    
    CMP BL,AL
    JC NEXT1       ;JUMP IF BL<AL
    MOV BL,AL
        
    NEXT1:       

    CMP BH,AL
    JNC NEXT2      ;JUMP IF BL>AL
    MOV BH,AL
    
    NEXT2:
    
    INC SI 
    LOOP LP
        
    MOV SMALLEST,BL
    MOV LARGEST,BH
    
    MOV AH,4CH
    INT 21H
CODE ENDS
END START