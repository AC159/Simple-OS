; Routine that reads the first n sectors following the boot sector from a
; specific disk device
; load DH sectors to ES:BX from drive DL

disk_load:
push dx      ; Store dx on the stack so we later recall 
             ; how many sectors we must read even if it is altered in the meantime

mov ah, 0x02 ; BIOS read sector routine
mov al, dh   ; Read dh sectors
mov ch, 0x00 ; Select cylinder/track 0
mov dh, 0x00 ; Select head 0
mov cl, 0x02 ; Start reading after the second sector (i.e. after our boot sector)

int 0x13     ; Interrupt the BIOS
jc disk_error ; Jump if there is an error reading the disk

pop dx       ; Restore dx from the stack
cmp dh, al   ; if al (sectors read) != dh (sectors expected)
jne disk_error ; display an error message
ret

disk_error:
mov bx, DISK_ERROR_MSG
call print_string
jmp $

; Variables
DISK_ERROR_MSG db "Disk read error!", 0
