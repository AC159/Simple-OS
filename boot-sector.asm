; Simple boot sector that loops forever

loop:
    jmp loop ; jump to the address of the current instruction

; $ represents the address of the current instruction and
; $$ is the address of the beginning of the current section
; times instruction tells the assembler to produce multiple copies of the next 
; instruction (i.e. db 0)
times 510-($-$$) db 0 ; tell the assembly compiler to pad the program with 0s 
                      ; until the 510th byte

dw 0xaa55 ; last word (magic number) of the boot sector 
          ; that tells the BIOS that it is a valid boot sector
