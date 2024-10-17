 TITLE PGM11_5:SUBSTRING DEMONSTRATION
 
 .MODEL SMALL
 .STACK 100H
 .DATA
 MSG1 DB 'ENTER SUBST',0DH,0AH,'$'
 MSG2 DB 0DH,0AH,'ENTER MAINST',0DH,0AH,'$'
 MAINST DB 80 DUP(0)
 SUBST DB 80 DUP(0)
 STOP DW ?         ;last place to begin search
 START DW ?        ; place to resume search
 SUB LEN DW ?       ;substring length
 YESMSG DB 0DH,0AH,'SUBST IS A SUBSTRING OF MAINSTS'
 NOMSG DB 0DH,0AH,'SUBST IS NOT A SUBSTRING OF MAINST'
 .CODE
 
 MAIN PROC
 MOV AX,@DATA
 MOV DS,AX
 MOV ES,AX    
 ;prompt for SUBST
 
 MOV AH,9     ;print string fcn
 LEA DX,MSG1  ;substring prompt
 INT 21H      ;prompt for SUBST  
 ;read SUBST 
 
 LEA DI,SUBST
 CALL READ_STR  ;BX has SUBST length
 MOV SUB_LEN,BX  ;save in SUB_LEN
 ;prompt for MAINST
 
 LEA DX,MSG2     ;main string  prompt
 INT 21H         ;prompt for MAINST
 ;read MAINST
 
 LEA DI,MAINST
 CALL READ_STR   ;BX has MAINST length
 ;see if string null or SUBST longer than MAINST
 
 OR BX,BX        ;MAINST null?
 JE NO           ;yes,SUBST not a substring
 CMP SUB_LEN,0   ;SUBST null?
 JE NO           ;yes,SUBST not a substring
 CMP SUB_LEN,BX   ;substring>main string?
 JG NO             ;yes,SUBST not a substring
 ;see if SUBST is a substring of MAINST
 
LEA SI,SUBST       ;SI pts to SUBST
LEA DI,MAINST       ;DI pts to MAINST
CLD              ;left to right processing
;compute STOP

MOV  STOP,DI      ;STOP has MAINST address
ADD STOP,BX       ;add MAINST length
MOV CX,SUB_LEN
SUB STOP,CX       ;subtract SUBST length
;initialize start

MOV START,DI       ;place to start search

REPEAT:
;compare characters
MOV CLEN            ;length of substring 
MOV DI,START        ;reset DI
LEA SI,SUBST       ;reset SI
REPE CMPSB         ;compare characters
JE YES             ;SUBST found
;substring not found yet

INC START        ;update START
;see if start <=stop

MOV AX,START
CMP AX,STOP      ;START<=STOP?
JNLE NO          ;no,exit
JMP REPEAT        ;keep going
;display results  

YES:  
      LEA DX,YESMSG
      JMP DISPLAY
NO:
      LEA DX,NOMSG
DISPLAY: 
      MOV AH,9
      INT 21H       ;display results
;DOS exit
  MOV AH,4CH
  INT 21H
MAIN ENDP
;READ_STR goes here
 END MAIN 
            
 