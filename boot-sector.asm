; Simple boot sector that prints characters to the screen and loops forever

mov ah, 0xe ; load register ah with the # of the 'print char' subfunction
mov al, 'H' ; write ASCII code that we want to print in register al
int 0x10    ; interrupt the CPU 
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $; jump to the address of the current instruction

; $ represents the address of the current instruction and
; $$ is the address of the beginning of the current section
; times instruction tells the assembler to produce multiple copies of the next 
; instruction (i.e. db 0)
times 510-($-$$) db 0 ; tell the assembly compiler to pad the program with 0s 
                      ; until the 510th byte

dw 0xaa55 ; last word (magic number) of the boot sector 
          ; that tells the BIOS that it is a valid boot sector
