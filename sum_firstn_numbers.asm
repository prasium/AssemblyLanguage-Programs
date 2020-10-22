;Print sum of first n natural numbers

org 100h

mov [2000h],10   ; store 10(n) in memory address 2000h


    
    mov ax, [2000h]
    mov bx,0
                           ;using programmatically
    
   sumloop:
           jz exit        ; this condition will check for zero flag
                            ; if it is set then it will jump to exit label
           add bx,ax
           dec ax
           jmp sumloop 
           
     exit:             
     
                        

ret




