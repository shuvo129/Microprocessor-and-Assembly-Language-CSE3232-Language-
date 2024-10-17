;Write an assembly language program that take an input string and make reverse string.

.MODEL SMALL
.STACK 100h
.DATA

STRING DB 'I LOVE BANGLADESH'  ;variable name'string'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX                 ;data segment accesing the AX value
    
    
    LEA SI,STRING             ;SI source index register that used to point to memory location 
;MOV SI,OFFFSET STRING  


MOV CX,18                      ; CX counter register that serves as a loop mcounter of string


LOOP1:
MOV BX,[SI]                   
PUSH BX                       ;pushing stack
INC SI                        ;increment the source index register
LOOP LOOP1                    ;end loop


MOV CX,18

LOOP2:
POP DX                        ;pop stack value
MOV AH,02H                    ;prepare for output
INT 21H                       ;increment for output
LOOP LOOP2                    ;end loop

MAIN ENDP
END MAIN