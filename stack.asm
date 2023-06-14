; Boot sector where we use the stack

mov ah, 0x0e ; scrolling teletype BIOS routine

mov bp, 0x8000 ; set the base of the stack
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx     ; we are popping 16 bits but we only want the lowest 8 bits which is our
mov al, bl ; our character
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe]
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
