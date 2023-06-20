; helper function that prints a string. The address of the string must be in 
; register bx

print_string:
push ax ; push the contents of register ax onto the stack before using it
mov ah, 0x0e

print:
mov al, [bx] ; copy the contents of the address located in register bx (this is the first character)
cmp al, 0 ; check if it is the null terminating character
je end ; return if we are at the last value of the string

int 0x10 ; print the char
inc bx ; increment the address by a byte to point to the next character 
       ; (we can also use add bx, 0x1 to go to the next address since each address accesses a byte of data)
jmp print

end:
pop ax ; replace the original contents of register ax
ret