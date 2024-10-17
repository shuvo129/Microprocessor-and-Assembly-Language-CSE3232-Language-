include 'emu8086.inc'
 .MODEL SMALL
.STACK 100H
.DATA
N DB ?
MSG DB 'ENTER THE INPUT: ','$'
MSG2 DB 10,13,'RESULT OF SUMMATION: ','$'
.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX,MSG
    INT 21H
    
  INPUT:
    
    MOV AH,1
    INT 21H
    
    MOV N,AL
    SUB N,48
    MOV CL,0 
    MOV BL,10
    CALL NEWLINE
    
  SUM:
    CMP N,0
    JZ DISPLAY 
    
    CMP N,3
    
    JG EXIT1
    
    ADD CL,N
    DEC N
    JMP SUM
    
  DISPLAY:
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    
    MOV AH,2
    MOV DL,CL
    ADD DL,48
    INT 21H   
    

     
  EXIT:
    MOV AH,4CH
    INT 21H 
      EXIT1: 
     PRINT "Please reload the code and enter any input range (0 to 3)"
     MOV AH,4CH
    INT 21H 
    
    
    MAIN ENDP

NEWLINE PROC
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    RET
    NEWLINE ENDP 

END MAIN