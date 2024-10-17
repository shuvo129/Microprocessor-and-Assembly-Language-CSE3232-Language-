;Read a String and Find Out the First & Last Alphabetic Charecture From the Input String

.MODEL SMALL 
.STACK 100H 



.DATA     
    PROMPT DB 'TYPE A LYNE OF TEXT',0DH,0AH,'$'  
    
    NOCAP_MSG DB 0DH, 0AH, 'No capitals $'        
    
    CAP_MSG   DB   0DH, 0AH, 'First Capital = ' 
    FIRST DB '] '
              DB  0DH, 0AH,  'LAST CAPITAL = '   
    LAST  DB '@ $'          

                        
              
.CODE 

MAIN PROC   
    
;INITIALIZE DS
     MOV AX, @DATA
     MOV DS, AX
     
;DISPLAY OPENING MASSAGE
     MOV AH, 9                  ;display string fuc=nction
     LEA DX, PROMPT             ;get opening message
     INT 21H                    ;display it
     
;READ AND PROCESS A LINE OF TEXT
     MOV AH, 1                  ;read char function
     INT 21H                    ;chal in AL

WHILE:
;WHILE CHARECTER IS NOT A CARRIAGE RETURN DO
     CMP AL, 0DH                ;CR?
     JE END_WHILE               ;yes,exit
     
;IF CHARECTURE IS A CHAPITAL LETTER
     CMP AL, 'A'                ;char >= 'A'
     JNGE END_IF                ;not a capital letter
     CMP AL, 'Z'                ;char <='Z'
     JNLE END_IF                ;not a capital letter
     
;THEN
;IF CHARECTER PRECEDES FIRST CHAPITAL
     CMP AL, FIRST              ;char < first capital?
     JNL CHECK_LAST             ;no,  >=  
     
     ;THEN FIRST CAPITAL= CHARECTRE
     MOV FIRST, AL              ;FIRST = char
;END_IF 



CHECK_LAST:
     
;IF CHARECTURE FOLLOW LAST CAPITAL    
     CMP AL, LAST               ;CHAR > LAST CAPITAL?
     JNG END_IF                 ;NO <=
     
                     
;THEN LAST CAPITAL = CHARECTURE
     MOV LAST, AL               ;LAST = CHAR
     
;END_IF
END_IF: 
      
     
;READ A CHARECTURE
     INT 21H                    ;CHAR IN AL
     JMP WHILE                 ;REPEAT  
     
     
     
      
     
END_WHILE:  


     ;DISPLAY RESULTS  
      MOV AH, 9                 ;DISPLAY STRING FUNCTION
     
;IF NO CAPITALS WERE TYPED
     CMP FIRST, ']'             ;FIRST  ']'
     JNE CAPS                   ;NO, DISPLAT RESULTS
     
;THEN
     LEA DX, NOCAP_MSG          ;NO CAPITALS
     JMP DISPLAY
     
     CAPS:
          LEA DX, CAP_MSG       ;CAPITALS
          
     DISPLAY:
             INT 21H            ;DISPLAY MESSAGE
             
     ;END_IF
     ;DOS EXIT
            MOV AH, 4CH
            INT 21H
            
            
      MAIN ENDP
           END MAIN
