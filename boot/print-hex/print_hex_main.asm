; Boot sector that prints a 2 byte hex number as a string

[ org 0x7c00 ]

; the hex values must be capital letters
mov dx, 0xffff ; store the value to print in dx
call print_hex ; call the function
jmp $

%include "../print-hex/print-hex-helper.asm"
%include "../print-str/print_string_helper.asm"

; Padding and magic number to tell the BIOS that this is a valid boot sector
times 510 - ( $ - $$ ) db 0
dw 0xaa55