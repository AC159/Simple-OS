; helper function that prints a string. The address of the string must be in 
; register bx

print_string:
mov ah, 0x0e

print:
mov al, [bx] ; copy the contents of the address located in register bx (this is the first character)
cmp al, 0 ; check if it is the null terminating character
je end ; return if we are at the last value of the string

int 0x10 ; print the char
inc bx ; increment the address by a byte to point to the next character
jmp print

end:
ret