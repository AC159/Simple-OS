; Boot sector where we test out conditional statements

mov ah, 0x0e

mov bx, 30

cmp ax, 4
jg else_if
mov al, 'A'
jmp end

else_if:
cmp bx, 40
jg else
mov al, 'B'
jmp end

else:
mov al, 'C'

end:
int 0x10

jmp $

; Pad the rest of the boot sector with zeros
times 510-($-$$) db 0
dw 0xaa55
