;PROGRAM TO CHECK WHETHER A STRING IS A PALLINDROME OR NOT

org 100h

.data
 
 string db "RADAR$"      ; define string to check as input here
 msg1 db "String is Pallindrome $"
 msg2 db "String is not Pallindrome $"

.code
    mov ax,@data    ; address of data directive stored at ax reg
    mov ds,ax       ; this address is assigned to data segment reg


lea di, string    ; loads EA of String 
mov si, di        ; mov value of DI reg to SI reg
  size:           ; label to find length of string
    cmp [si], '$'   ;checks end of string reached or not
    je strlen       ; if end reached jump to strlen label
    inc si          ; increase SI pointer
    jmp size        ; jump back to loop size
    
strlen:
dec si              ;decrease by 1 to point the last character of string
cmp di,si           ;if string both are equal means length is one
je is_palindrome  ; single char is always a palindrome


next:          ; next label evaluates by comparing left most pointer to right most pointer of string
    cmp si,di
    jl is_palindrome    ; if si becomes greater than di than jmp to label cause its already a palindrome
    mov al, [si]        ; value pointed by si stored at al reg
    mov bl, [di]        ; value pointed by di stored at bl reg
    cmp al, bl          ; compare whether both char are equal
    jne not_palindrome  ; if not equal jump to not_palindrome label
    inc di              ; increase di pointer by 1
    dec si              ; decrease si pointer by 1
loop next               ; continue loop till half way of strlength


is_palindrome:  ;if string is palindrome!
   mov ah, 9
   lea dx, msg1      ; loads EA of msg1 into dx reg
   int 21h           ; calls interrupt to display string
jmp exit

not_palindrome: ;if string is not palindrome!
   mov ah, 9
   lea dx, msg2
   int 21h
exit:
ret