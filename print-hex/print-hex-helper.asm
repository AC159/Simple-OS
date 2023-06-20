; Helper routine that prints a 2 byte hex number as a string
; The hex value to print must be located in register dx

; prints the value of DX as hex.
print_hex:
mov ax, dx
shr ax, 12   ; shift right by 4 bits to keeps the 4 leftmost bits
and al, 0x0f ; extract the 4 leftmost bits from register al
add al, '0'  ; make text
cmp al, '9'
jg greater_than_9
mov byte[HEX_OUT + 2], al
jmp char2
greater_than_9:
add al, 7
mov byte[HEX_OUT + 2], al

; Print the second character
char2:
mov ax, dx
shr ax, 8    ; shift right by 4 bits to keeps the 4 leftmost bits
and al, 0x0f ; extract the 4 leftmost bits from register al
add al, '0'  ; make text
cmp al, '9'
jg greater_than_92
mov byte[HEX_OUT + 3], al
jmp char3
greater_than_92:
add al, 7
mov byte[HEX_OUT + 3], al

; Print the third character
char3:
mov ax, dx
shr ax, 4    ; shift right by 4 bits to keeps the 4 leftmost bits
and al, 0x0f ; extract the 4 leftmost bits from register al
add al, '0'  ; make text
cmp al, '9'
jg greater_than_93
mov byte[HEX_OUT + 4], al
jmp char4
greater_than_93:
add al, 7
mov byte[HEX_OUT + 4], al

; Print the fourth character
char4:
mov ax, dx   ; no need to shift since we can direclty obtain the 4 leftmost bits
and al, 0x0f ; extract the 4 leftmost bits from register al
add al, '0'  ; make text
cmp al, '9'
jg greater_than_94
mov byte[HEX_OUT + 5], al
jmp print_str
greater_than_94:
add al, 7
mov byte[HEX_OUT + 5], al

print_str:
mov bx, HEX_OUT ; print the string pointed to by BX
call print_string ; the caller must inclue the print_string_helper.asm function
ret

; global variables
HEX_OUT:
db '0x0000', 0
