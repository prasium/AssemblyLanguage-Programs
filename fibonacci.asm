;Program for fibonacci series upto n terms

org 100h

.data                                            
    input dw ?      ; variable to take user entered input     
    asklabel db "Enter number of terms (max limit 25, cause 16bit architecture) : $"
    label db 10,13, "Fibonacci series upto given terms : $" 
    space db " $" 
    var1 dw ?       ; variable to hold temp values
    var2 dw ?       ; var to hold temp values
.code
        
    lea dx,asklabel ; this displays asklabel string on console
    mov ah,9
    int 21h
      
    call takeInput  ; calls takeInput procedure to take user Input 
    mov input,bx          
        
    lea dx,label    ; Displays the label string on console
    mov ah,9
    int 21h  
    
    mov bx,0        ; bx holds value 0
    mov cx,1        ; cx holds value 1
    mov si,1        ; si register set to 1 to keep counter of n terms
    
    printfib:       ; label for displaying each term
        cmp si,input    ; checks if si value greater than n
        jg end          ; if yes then jump to end 
        mov var1,bx     ; temp copy bx reg value to var1
        mov var2,cx     ; copy cx reg value to var2 
        call dis        ; calls display procedure which displays multiple digits
        call spaceprint ; calls space print to show space between terms
        mov bx,var1     ; fetch back var1 value to bx reg
        mov cx,var2     ; fetch back var2 value to cx reg
        mov ax,bx       ; mov bx to ax reg
        add ax,cx       ; then add cx value to ax, (term1+term2)
        mov bx,cx       ; mov bx to cx (term1=term2)
        mov cx,ax       ; mov cx to ax (term2=term1+term2)
        inc si          ; increase si pointer value by 1
        jmp printfib    ; jump back to label specified
        
    end:           
ret

;PROCEDURE FOR TAKING MULTIPLE DIGITS INPUT FROM CONSOLE
takeinput proc near
    inputNum:          ; label for converting the single char input into a integer number
      mov dx,10
      mov ah,1          ;calls input interrupt
      int 21h
      mov ah,0
      cmp al, 13   ; check if user pressed carriage return (enter)
      je  exit     ; if above comparison is true then jump to exit label

      sub al, 48     ;converts ascii to decimal,0 starts with ascii val 48 so we subtract it to get equivalent digit

      mov cx, ax     ;moving unit digit(<9) value in cl register, like : 3 in 53
      mov ax, bx   ;  storing previous bl value in al register

      mul dx       ; multiply the al value with 10 

      add ax, cx   ; add new value to previous one, (unit digit val + previous base multiplied digits)
      mov bx, ax   ; mov back the digits currently to bx reg

      jmp inputNum  ; jump back until user press enter.   
      exit:
      ret
takeinput endp

;PROCEDURE FOR ADDING SPACE CHARACTER
spaceprint proc near 
        lea dx,space   ;eff address of space label is loaded
        mov ah,9
        int 21h 
        xor dx,dx     ; clears dx register 
        ret
spaceprint endp
    
;PROCEDURE FOR DISPLAYING MULTIPLE DIGITS VALUE TO CONSOLE
dis PROC near
      mov ax,bx     ; value of current term moved to ax reg
      mov cx,0      ; counter set to 0
      mov bx,10     ; set value of bx reg to 10
   
pushnum: 
       mov dx,0
       div bx       ; remainder stored in dl
       add dl,48    ; convert to ascii add 48
       push dx      ; push remainder in stack
       inc cx       ; counter reg for counting number of digits
       cmp ax,0     ; loop exit condition
       jne pushnum  ; if not zero continue pushing

display: 
       pop ax       ;pop back digit  
       mov dx,ax
       mov ah,2     ; display digit by digit on console
       int 21h
       loop display ; loop until cx reg is 0
RET
dis ENDP     



