.model small
.stack 100h
.data
  A db ?
  
.code
   main proc
    
    mov ah,1
    int 21H       ;single input
    mov A,al 
    
    
    mov ah,2
    mov dl,10      ;newline
    int 21H 
         
         
    mov dl,13      ;carrage_return
    int 21H 
           
    mov ah,2
    mov dl,A        ;single character output
    int 21H
     
    
    mov ah,4CH       ;dos exit
    int 21H
    
  main endp 
  end main           