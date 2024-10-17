         ;REVERSE STRING USING STACK  QUESTION 1.b)USING STACK
.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
    
;DISPLAY USER PROMT 

 MOV AH, 2          ;PREPARE3 TO DISPLAY
  MOV DL,'?'         ;CHAR TO DISPLAY
 INT 21H            ;DISPLAY '?'
 
 ;INITIALIZE CHARACTER COUNT 
 
 XOR CX,CX  ;COUNT=0 
 
 ;READ A CHARACTER 
 
 MOV AH, 1 ;PREPARE TO READ
  INT 21H   ;READ A CHAR
  ;WHILE CHARACTER IS NOT A CARRIAGE RETURN DO
  
  WHILE_: 
  
     CMP  AL,0DH    ;CR? 
     JE    END_WHILE    ;YES,EXIT LOOP
  
  ;SAVE CHARACTER ON THE STACK AND INCREMENT COUNT 
  
  PUSH AX  ;PUSH IT ON STACK
  INC CX    ;COUNT=COUNT+1
  ;READ A CHARACTER
    
    INT 21H ;    ;READ A CHAR
    JMP WHILE_  ;LOOP BACK
    
    END_WHILE:
    
    ;GO TO A NEW LINE
    
       MOV AH, 2    ;DISPLAY CHAR FCN
       MOV DI,0DH   ;CR 
       
       INT 21H       ;EXECUTE
       MOV DL,0AH      ;LF 
       INT 21H         ;EXECUTE
       JCXZ EXIT        ;EXIT IF NO CHARACTERS READ
       ;FOR COUNT TIMES DO
       TOP:
       ;POP A CHARACTER FROM THE STACK
       
       POP DX           ;GET A CHAR FROM STACK
       ;DISPLAY IT
       
       INT 21H          ;DISPLAY IT
       LOOP TOP
       
       ;END_FOR
       
       EXIT:
       
       MOV AH,4CH
       INT 21H
       MAIN ENDP
            END MAIN
       