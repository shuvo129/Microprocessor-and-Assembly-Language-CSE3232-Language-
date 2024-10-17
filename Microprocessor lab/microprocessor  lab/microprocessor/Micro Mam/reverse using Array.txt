
.MODEL SMALL
.STACK 100H

.DATA
    ARR DB 100 DUP ?
    MSG DB "No of Element: $"
    MSG1 DB 0DH, 0AH, "Enter the string: $"
    MSG2 DB 0DH, 0AH, "Reversed string: $"
    CHOICE DB ?
.CODE
MAIN PROC
  MOV AX, @DATA
  MOV DS, AX
  
  LEA DX, MSG
  MOV AH, 9
  INT 21H
  
  MOV AH, 1
  INT 21H
  MOV CHOICE, AL
  SUB CHOICE, 30H  ;converting the input
  
  LEA DX, MSG1
  MOV AH, 9
  INT 21H
  
  LEA SI, ARR   ;loading the array
  MOV AH, 1
  MOV CL, CHOICE   ; counter for no of elements in array
  
  INPUT_ARR: 
    INT  21H 
    MOV [SI],AL   ; moving the input into the array
    INC SI      ; increment the index
    DEC CL     ; decrement the counter
    JNZ INPUT_ARR   ; take input untill the CL=0
    
    LEA DX,MSG2
    MOV AH, 9
    INT 21H
    SUB SI,1
    
    MOV AH, 2
    MOV CL, CHOICE
    
    OUTPUT_ARR:
       MOV DL,[SI]
       INT 21H
       
       DEC SI
       DEC CL
       JNZ OUTPUT_ARR
       
       
       MOV AH,4CH
       INT 21H
       
 MAIN ENDP
     END MAIN 



