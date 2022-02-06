[org 0x0100]
jmp start
    roll_no: db "20P-0165"
    roll_no_length: dw 8

; SubRoutine That will clear the screen
clrscr:     
    push es
    push ax
    push di

    mov  ax, 0xb800
    mov  es, ax
    mov  di, 0

    nextloc:
        mov  word [es:di], 0x0720
        add  di, 2
        cmp  di, 4000
        jne  nextloc

    pop  di 
    pop  ax
    pop  es
    ret

print_roll_no:
    push bp
    mov  bp, sp
    push es
    push ax         ; ah => 0x07(Black Background) al => (RollNo character) 
    push cx         ; cx will store the length of the roll_no
    push si         ; si will traverse on the roll_no
    push di 
    push bx

    ; MID CALCULATION LOGIC
    mov bx, 4000        ; Ending point of the screen
    shr bx, 1             ; Mid of the screen is in bx (bx/2)

    mov cx, [bp + 4]        ; Length of the screen moved to cx
    shr cx, 1                 ; Half of string length (cx/2)

    sub bx, cx              ; Mid will store in bx

    mov ax, 0xb800
    mov es, ax
    mov di, bx              ; MID GOES TO DI
    xor cx, cx              ; Clean the counter register

    mov si, [bp + 6]            ; Starting address of roll_no
    mov cx, [bp + 4]            ; length of a roll_no 
    mov ah, 0x07                ; Black Background

    roll_no_nextchar:
        mov al, [si]
        mov [es:di], ax

        add di, 2
        add si, 1

        loop roll_no_nextchar       ; cx will be reduced on each iteration

    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 4
start:
    ;call clrscr
    mov bx, roll_no
    push bx

    push word [roll_no_length]
    call print_roll_no

    mov ah, 0x1
    int 0x21

    mov ax, 0x4c00
    int 0x21