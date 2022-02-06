[org 0x0100]
jmp start
    X: dw 20
    Y: dw 15
    result: dw 0
GCD:
    push bp
    mov bp, sp
    push ax
    push bx

    mov ax, [bp + 4]        ;Y Value
    mov bx, [bp + 6]        ;X Value

    ;if condition
    cmp ax, 0
    jne elif
        mov [result], bx
        pop bx
        pop ax
        pop bp
        ret 4               ; 2 Parameters given
    ;elif condition
    elif:
        cmp bx, ax
        jae else
            ;elif
            push ax
            push bx
            call GCD
            pop bx
            pop ax
            pop bp
            ret 4
    ;else condition
    else:
        sub bx, ax
        push bx
        push ax
        call GCD
        pop bx
        pop ax
        pop bp
        ret 4

start:
    push word [X]
    push word [Y]
    call GCD

    mov ax, 0x4c00
    int 0x21