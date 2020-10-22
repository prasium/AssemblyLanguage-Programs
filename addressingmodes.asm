                                      
; PROGRAM FOR ADDITION SUBTRACTION MULTIPLICATION DIVISIONN
;  using register-register addressing mode, immediate addressing mode and register indirect addressing mode.
                                    
org 100h

mov al,23
mov bl,15
 mov [2000h], 15   ; place 15 in memory location 2000 hexadecimal       
   
;REGISTER REGISTER MODE
add al,bl ; addition al=al+bl = 23+15=38
mov bl,30 ; bl becomes 30
sub al,bl ; subtraction al=al-bl = 38-30=8
mov bl,2 ; bl becomes 2
mul bl;   ; multiply al with bl, al=al*bl=16
mov bl,4 ;  bl becomes 4
div bl;    ; divides al by bl, al =16/4= 4


;IMMEDIATE MODE  
add al,17 ; addition al=al+17 = 4+17=21
sub al,15 ; subtraction al=al-15 = 21-15=6



;REGISTER INDIRECT MODE

mov ax,4
mov bx,2000h

add ax,[bx]                                   
sub ax,[bx]
mul [bx]
div [bx]

                                      
ret




