.MODEL SMALL
.STACK 100H
;.CODE

.DATA 
N DW 0 ;define word      (name   DB   initial-value)
X DB 80 DUP(?) ;define byte     
               ;80 DUP(2) is equvalent to 80 times 2. 2,2,2,.... 
               ;means duplicating an expression a given number of tioms


MSG1 DB 'Input String : $'
MSG2 DB 10, 13,'Output String : $'   ; in ASCII 10= 'new line' and 13='carriage return'   see book page 69


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ;display string function and display msg1  
    
    
    MOV AH,9     ; display string function
    LEA DX, MSG1 ;get first message      ;LEA=load effective address (puts a copy of source offset adress)
    INT 21H      ;display message
    
    
    MOV SI, 0        ;source index
    INPUT:
        MOV AH, 1    ; Read charecture function
        INT 21H      ; charecture in AL
        CMP AL, 0DH  ; is it equal to newline?
        JE BREAK     ;jump equal to BREAK
        
        MOV X[SI], AL;point the memory location by X[SI] of the charecture is readed now
        INC SI       ;By incrementing the contents of SI, consecutive memory locations can be accessed       
        JMP INPUT 
    
    BREAK:
        MOV AH,9     ; display string function
        LEA DX, MSG2 ;get second message
        INT 21H      ;display message
        MOV N, SI    ;save the indexs number
         
         
         
         
         
    MOV SI, 0    
    MOV AH, 2        ; display charecture function
    NEXT:
        CMP SI, N    ; TRUE, if have no input or all are done
        JE EXIT 
        
        
        MOV BL, X[SI]         ;Base register serve as an address register
        
        ;CONVERTING UPPERCASE TO LOWER CASE
        CMP BL, 'A'
        JL Print              ;jump if less
        CMP BL, 'Z'
        JG lower              ;jump if greater
        ADD BL, 32            
        JMP Print
        
        ;CONVERTING LOWER CASE TO UPPERCASE
        Lower: 
            CMP BL, 'a'
            JL Print
            CMP BL, 'z'
            JG Print
            SUB BL, 32
    
        Print:  
            MOV DL, BL     
            INT 21H
            INC SI            ;By incrementing the contents of SI, consecutive memory locations can be accessed
            JMP NEXT
  
    EXIT: 
        MOV AH,4CH
        INT 21H               ;DOS exit
        MAIN ENDP
END MAIN