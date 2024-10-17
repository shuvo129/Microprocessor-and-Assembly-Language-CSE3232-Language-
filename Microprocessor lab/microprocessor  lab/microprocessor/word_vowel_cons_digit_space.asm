.MODEL SMALL
.STACK 100H
.DATA
     str DB 80 DUP(?)
     MSG DB 'TYPE A LYNE OF TEXT',0DH,0AH,'$'
     Printtotal DB 10,13,'total number:$' 
     PrintVowel DB 10,13,'Number of Vowels:$'
     PrintCons DB 10,13,'Number of consonents:$'
     PrintSpace DB 10,13,'Number of Spaces:$'      
     PrintDigit DB 10,13,'Number of Digits:$'
     bc DB '0'
     cc DB '0'
     spa DB '0'
     num DB '0'
     tot DB '0'
     
.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX,MSG
    INT 21H
    
    MOV BL,'0'
    MOV CL,'0'
    MOV SI,0
    
 MOV AH,1
 next:
     INT 21H
     CMP AL,0DH
     JE print
     MOV str[SI],AL
     
 upper:
     CMP str[SI],'A'
     JL special
     CMP str[SI],'Z'
     JG lower
     JMP count
     
 lower:
      CMP str[SI],'a'
      JL special
      CMP str[SI],'z'
      JG special
      
 count:
      CMP str[SI],'A'
      JZ vowel
      CMP str[SI],'a'
      JZ vowel 
      CMP str[SI],'E'
      JZ vowel
      CMP str[SI],'e'
      JZ vowel 
      CMP str[SI],'I'
      JZ vowel
      CMP str[SI],'i'
      JZ vowel 
      CMP str[SI],'O'
      JZ vowel
      CMP str[SI],'o'
      JZ vowel 
      CMP str[SI],'U'
      JZ vowel
      CMP str[SI],'u'
      JZ vowel
      JMP cons
      
 vowel:
      ADD bc,1
      ADD tot,1
      jmp special
      
cons:
     ADD cc,1
     ADD tot,1
     
special:
     CMP str[SI],' '
     JNE digit
     ADD spa,1
     ;ADD tot,1
     JMP ignore
     
digit:
     CMP str[SI],'0'
     JL ignore
     CMP str[SI],'9'
     JG ignore
     ADD num,1
     ADD tot,1 
   
     
ignore:
      INC SI
      JMP NEXT
      
print:
     MOV AH,9
     LEA DX,Printtotal
     INT 21H
     
     MOV AH,2
     MOV DL,tot
     INT 21H
     
     MOV AH,9
     LEA DX,PrintVowel
     INT 21H
     
     MOV AH,2
     MOV DL,bc
     INT 21H
     
     MOV AH,9
     LEA DX,PrintCons
     INT 21H
     
     MOV AH,2
     MOV DL,cc
     INT 21H
     
     MOV AH,9
     LEA DX,PrintSpace                                                               MN 
     INT 21H
     
     MOV AH,2
     MOV DL,spa
     INT 21H
     
     MOV AH,9
     LEA DX,PrintDigit
     INT 21H
     
     MOV AH,2
     MOV DL,num
     INT 21H
     
Exit:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
    
 END MAIN                   
                                         
                    
                    
                    
                    
     
     