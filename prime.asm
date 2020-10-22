;PROGRAM TO CHECK IF A NUMBER IS PRIME OR NOT

org 100h


.data
   num dw 97 ; Input of number defined here   
   msg1 db "Number is prime$"
   msg2 db "Number is not prime$"
.code
  proc main 
  mov ax,@data
  mov ds,ax    ; making data segment point to data directive
  
  mov bx,num   ; stores input number in bx register
  cmp bx,2     ; check if input is 2
  je isPrime   ; if yes then jump to isPrime label
  mov cx,bx    ; copies value of bx reg to cx reg
  shr cx,1     ; makes cx half so that loop checks upto n/2 
  mov bp,2   ; base pointer register acts as an iterator
  loopcheck:
    
    mov ax,bx     ; move value of bx register to ax for division
    div bp        ; divide by iterator value    
    cmp dx,0      ; see if the remainder is zero
    je isNotPrime ; if true then jump to label  
    
    cmp bp,cx     ; check for loop break condition
    jg isPrime    ; if iterator becomes greater than n/2 then jump to label
    inc bp        ; increase iterator
    mov dx,0      ; set dx reg to zero
    jmp loopcheck
                 
  
    
isPrime:          ; label to handle if number is prime
    lea dx,msg1   ; load eff address of msg1
    mov ah,9     
    int 21h       ; calls interrupt to display
    ret 

isNotPrime:      ; label to handle if its not prime
    lea dx,msg2  ;load eff address of msg2
    mov ah,9
    int 21h      ; calls interrupt to display
ret
main endp


