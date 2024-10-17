.MODEL SMALL
.STACK 100H
.DATA
  MSG DB 'HELLO CSE!$'
  
 .CODE
   
   MOV AX,@DATA   ;initialize ds
   MOV DS,AX
   
   LEA DX,MSG
   MOV AH,9      ;display
   INT 21H
   
   
   MOV AH,4CH
   INT 21H
   
     MAIN ENDP
   END MAIN