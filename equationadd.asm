; PROGRAM TO TAKE AN INPUT AND PERFORM X=Y+4
org 100h

.data   
    msg1 db "Input $"
    msg2 db 10,13, "Result is $"
    
.code  
proc main


mov dx, 10        ; base 10 for decimal numbers will multiply after every iteration  
mov bx, 0         ; stores remainder digit

lea dx,msg1
mov ah,9
int 21h        
        
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
      mov bx, ax   ; mov back the digits currently to bl reg

      jmp inputNum  ; jump back until user press enter.   

exit:        
      add bx,4      ; adds 4 to value of input
      mov ax,bx     ; moves result to ax reg
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
     
lea dx,msg2
mov ah,9
int 21h


display: 
       pop ax       ;pop back digit  
       mov dx,ax
       mov ah,2     ; display digit by digit on console
       int 21h
       loop display ; loop until cx reg is 0
       ret
endp main