;PROGRAM TO CHECK WHETHER A NUMBER IS A PALLINDROME OR NOT

org 100h     
   
.data
    num1 dw 14641    ; define word input number
    num2 dw ?      ; temp var to store reverse of number
    arr db 10 dup(0)            ;array of size 10 all values 0
    msg1 db "Number is a pallindrome$"
    msg2 db "Number is not a pallindrome $"
    
.code
 
    mov ax,num1   ;moves value of num1 to ax register
    lea di, arr ; loads effective address of arr in destination index reg
    
     
revNum:
    mov bx,10 ; store 10 in bx for div
    mov dx,0  ; dx=0
    div bx ; divides ax=ax/bx
    mov arr[di],dl ; move remainder in index i of array, remainder is stored in dx on division
    mov num2,ax    ; moves divided result in a temp var num2
    inc di ; increases si pointer to next element
    cmp num2,0     ; compares whether num2 is greater than 0, eq. to num2>0
    jg revNum     ; if the above condition is true it will jump to revNum label like while loop
    
    lea si, arr  ; loads effective address of array in source index register
    dec di       ; decreases di by 1 cause to point to the last element
    
compare:  
    cmp di,si   ; compares starting pointer (di) and pointer from end (si)
    jl yes ; it will jump to yes if DI becomes less than SI
    mov al, arr[si] ;fetch element from array SI location and store it in register al
    mov bl, arr[di] ; similary does from DI location and store it in bl
    cmp al,bl    ; compare both values
    jne no       ; if not equal jump to no label
    dec di       ;decrease di pointer
    inc si       ;increase si pointer
    jmp compare  ; jump back to compare
    
yes:
    lea dx, msg1      ; loads EA of msg1 label defined in DS
    mov ah,9          ; stores ah=9 for interrupt
    int 21h           ; calls interrupt with ah value to output dx register content
    jmp exit          ; jumps to exit label
no:
    lea dx, msg2      ; loads EA of msg2
    mov ah,9
    int 21h
    jmp exit
exit:                 ;empty label
ret