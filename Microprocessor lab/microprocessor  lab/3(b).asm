 org 100h
.model small
.stack 100h
.data
arr db 5 dup(?)

a db 10,13,"Enter the number :$"
b db 10,13,"The array after sorting is:$"

.code
main proc
    mov ax,@DATA
    mov ds,ax
    ;For input
    
    mov ah,9
    lea dx,a
    int 21h
    mov cx,5
n: 

   mov ah,1
   int 21h
   sub al,30h
   mov arr[si],al
   inc si
   loop n
;For sorting
   mov cx,5
   mov si,0
sort:
    cmp cx,si
    jz next
    mov al,arr[si]
    mov bl,arr[si+1]
    cmp al,bl
    jb exchange
    add si,1
    jmp sort
exchange:
    mov arr[si],bl
    mov arr[si+1],al
    add si,1
    jmp sort
next:
    mov si,0
    sub cx,1
    cmp cx,0    ;dec cx
    jnz sort
;For print array indescending sorting 

mov ah,9
lea dx,b
int 21h
mov cx,6
mov[si],offset arr
mov ah,2
top:
     add arr[si],30h
     mov dl,arr[si]
     int 21h
     inc si
     loop top
t:
   move ah,4ch
   int 21h
   main endp
end main
    
       
   
    