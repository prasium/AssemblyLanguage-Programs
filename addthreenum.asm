
;Program to add three numbers



org 100h

.data
    num1 dw 14              ; num1 for first input
    num2 dw 99              ; num2 for second input
    num3 dw 100              ; num3 for third input
    msg1 db "Result is $"
        
.code  
    mov ax,@data
    mov ds,ax               ; load data segment reg to point data directive

   mov ax, num1             ; store val in ax reg of num1
   mov bx, num2             ; store val in bx reg of num2
   add ax,bx                ; perform addition store res in ax
   mov bx, num3             ; now fetch third num in bx reg
   add ax,bx                ; add again store result in ax reg
   
      mov cx,ax             ; temporary holding result

      lea dx,msg1           ; call output label to show
      mov ah,9
      int 21h

      mov ax,cx             ; storing back the result in ax reg to override ah value
      mov cx,0      ; counter set to 0
      mov bx,10     ; set value of bx reg to 10
 
; following statements will display the output of resultant addition
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

ret




