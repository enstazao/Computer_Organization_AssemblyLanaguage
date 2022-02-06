[org 0x0100]
jmp start
    N: dw 7
    fib_seq: dw 0
make_array_of_N:
    push bp
    mov bp, sp
    push cx
    push si
    
    mov cx, [bp + 4]            ;N
    clean:
        mov word [si], 0
        add si, 2
        loop clean
    pop si
    pop cx
    pop bp
    ret 2
;SubRoutine for calculating fib_sequence
calculate_fib:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push si

    cmp cx, 1
    ja add_prev
        ;else
        mov [si], cx
        add si, 2
        cmp cx, [bp + 4]
        jne call_func
            ;else
            pop si
            pop cx
            pop bx
            pop ax
            pop bp
            ret 2
    add_prev:
        mov bx, [si - 2]
        add bx, [si - 4]
        mov [si], bx

        add si, 2
        cmp cx, [bp + 4]
        jne call_func
            ;else
            pop si
            pop cx
            pop bx
            pop ax
            pop bp
            ret 2
    call_func:
        inc cx
        push word [bp + 4]
        call calculate_fib
        ;exit
        pop si
        pop cx
        pop bx
        pop ax
        pop bp
        ret 2
start:
    push word [N]
    mov si, fib_seq
    call make_array_of_N

    xor cx, cx
    push word [N]
    call calculate_fib

    mov ax, 0x4c00
    int 0x21