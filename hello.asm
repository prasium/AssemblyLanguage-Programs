
;Print Hello World program

org 100h

.data
  hellomsg db "Hello World!$"  
    
.code
mov dx,offset hellomsg
mov ah,9  
int 21h

ret