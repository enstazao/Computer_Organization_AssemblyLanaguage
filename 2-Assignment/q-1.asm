[org 0x0100]
jmp start
    fac_number: dw 1
    fac_result: dw 0
    n: dw 2
    series_sum: dt 0.0  ; 10 bytes defined and Negative Numbers are converted into it's 2's complement


; SubRoutine That will calculate teh factorial of a Number
Calculate_Factorial:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    mov ax, 1

    mov dx, [bp + 4]        ;fac_number
    ; Calulation of Zero factorial
    cmp dx, 0
        je exit

    ; Calculation of one factorial
    cmp dx, 1
        je exit

    mov cx, dx
    dec cx

    mov bx, cx
    mov ax, dx

    Outerloop:
        mul bx
        dec bx
        loop Outerloop
    exit:
        mov word [fac_result], ax       ;Result of the factorial
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp
    ret 2

;SubRoutine THat will Calculate_Summation
Calculate_Summation:
    push bp
    mov bp, sp
    push ax     ;Value needed to be pushed(factorial_number)
    push bx
    push cx
    push dx
    push si

    mov si, [bp + 4]        ;n
    inc si                  ; n = 2, k goes to 2 times
    xor dx, dx
    mov bh, 2

    Loop_:
        mov ax, dx      ; Value needed to be multiplied
        mul bh
        inc ax
        push ax
        call Calculate_Factorial
        mov cx, [fac_result]     ; Factorial of (2k + 1)! is stored in cx
        mov ax, dx               ; ax will have the power k
        div bh                   ; Remainder goes to ah if odd or power is even
        cmp ax, 0                ; If power if even that mean divison with positive 1 else negative 1
        je pos_one
            ;else
            mov ax, -1
        pos_one:                       
            cmp ax, -1
            je continue
                ;else
                mov ax, 1
            continue:
                push dx
                xor dx, dx
                div cx              ;Factorial is divided with value present at ax(-1 or 1)
                pop dx
                add [series_sum], ax      ;result goes to series_sum label

        inc dx          ;dx will run k times
        cmp dx, si
        jne Loop_

    pop si
    pop dx
    pop cx
    pop dx
    pop ax
    pop bp
    ret 2
start:
    ;push word [fac_number]   ; Passing Number whose factorial need to be calculate
    ;call Calculate_Factorial
    push word [n]
    call Calculate_Summation
    mov ax, 0x4c00
    int 0x21
    