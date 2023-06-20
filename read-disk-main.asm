; Boot sector that reads from the boot disk using the read-disk routine
[org 0x7c00]

mov [BOOT_DRIVE], dl ; BIOS stores the boot drive in dl, so let's 
                     ; remember this for later

mov bp, 0x8000       ; Set the stack safely out of the way at 0x8000
mov sp, bp

mov bx, 0x9000       ; Load 5 sectors to 0x0000(ES):0x9000(bx)
mov dh, 5            ; from the boot disk
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]     ; Print out the first loaded word
call print_hex       ; which we expect to be 0xdada, stored at address 0x9000

call print_nl        ; Print a new line

mov dx, [0x9000 + 512] ; Let's also print the first loaded word from the 2nd
call print_hex         ; loaded sector: should be 0xface

jmp $

; Load our helper functions
%include "../print-hex/print-hex-helper.asm"
%include "../print-str/print_string_helper.asm"
%include "../print-str/print-nl.asm"
%include "read-disk-routine.asm"

; Global variables
BOOT_DRIVE: db 0

; Boot sector padding
times 510 - ($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512-byte sector from the disk,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselves that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada ; sector 2
times 256 dw 0xface ; sector 3
