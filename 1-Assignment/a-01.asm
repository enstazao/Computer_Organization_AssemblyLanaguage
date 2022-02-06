[org 0x0100]
jmp start                   ; Unconditional Jump
    number: db 0x35         ; Define byte because the given number can take 8 bits
    result: db 0    ; 0xAC
start:
    mov byte al, [number]            ; Moving the Number In to al register
    mov byte cl, 8                   ; Number is of 8 bits to loop will run for 8 times
    outerloop:                  ; Label
        shr byte al, 1          ; Shift all bits of al to right and LSB bit goes to Carry bit
        rcl byte ah, 1          ; Rotate all bits of ah register to left and move bit present at carry bit to vacant position or at LSB postion
        dec cl                  ; subtract 1 from cl register
        jnz outerloop           ; If subtracting cl become 0 then donot jump
    mov [result], ah               ;reverse number will be in ah
    mov ax, 0x4c00              ; Move 4c00 in ax register
    int 0x21                    ; OS handler see value of ax 4c00 and exit the program