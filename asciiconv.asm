; converts an ascii string containing decimal digits into equivalent binary number


org 100h


.data
    str db 4 dup(0)             ; array of byte size 4 to store binary
    numstring db "987$"        ; input number ascii string
    space db " $"               ; for delimiting different digits (space)
    
.code
    mov ax,@data                
    mov ds,ax                   ; loads data segment of data directive
    xor ah,ah                   ; clears ah register
    lea bp,numstring            ; load the input string base address into bp reg
  
      nextele:                  ;label for printing each digit binary equivalent
         
          lea si,str            ; base address in si reg
          lea di,str            ; again base address in di reg
          mov al,[bp]           ; mov first character to al reg
          cmp al, 36            ; check if the character is null character
          je exit               ; if yes then go to exit
          sub al,48             ; subtract 48 from ascii numeric to get integer
        
        dobinary:               ; finds binary for digit
          xor ah,ah
          mov bl,2              ; storing base 2 in bl reg
          div bl;               ; div by 2
          mov str[si],ah        ; modulo 2 stored in str[si] position
          inc si                ; increase si pointer by 1
          cmp al,0              ; check if digit has become 0
          jne dobinary          ; if false then jump back to label
          
          printbinary:          ; prints binary equivalent for the digit
            dec si              ; decrease si pointer to point last digit
            mov dl,str[si]      ; mov value at si address to dl reg
            add dl,48           ; add 48 to get ascii equivalent
            mov ah,2
            int 21h             ; interrupt to print character
            cmp si,di           ; check if si > di
            jg printbinary      ; if true jump back to label
            inc bp              ; increase bp to get next digit in input string
            lea dx,space        ; to delimit space call interrupt
            mov ah,9
            int 21h
            jmp nextele         ; jmp to nextele label
 

    exit:
   
  
    
ret




