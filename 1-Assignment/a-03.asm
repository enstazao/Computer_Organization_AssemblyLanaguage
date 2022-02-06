[org 0x0100]
jmp start
    array_1: db 1, 3, 9, 2, 4, 8, 7, 1, 6, 5            ; Data For Finding sum of first half and second half
    array_size: db 10                                   ; Size of array_1 is 10
    first_half_sum: db 0                                ; label to store the array_1 first half sum
    second_half_sum: db 0                               ; label to store the array_1 second half sum

    array_2: db 11, 8, 4, 9, 3, 5, 8                    ; Array from which we need to find the minimum number
    array_2_size: db 7                                  ; array_2_size is 7
    min_array_2: db 0                                   ; label that stores minimum number

    after_div_result: db 0
start:
    ; Finding The sum of first half and second half of array
    xor bx, bx              ; Cleaning the registers
    xor si, si
    xor dx, dx
    xor ax, ax
    xor cx, cx

    mov al, [array_size]            ; Moving the array_1 size to al register
    shr byte al, 1                  ;divison by 2
    mov cl, al                      ; counter register have loop branching condition that how much time loop need to be runed
    mov bx, array_1                 ; bx point to array_1 starting index

    firstloop:
        add byte ah, [bx]
        add bx, 1
        dec cl
        jnz firstloop
    mov [first_half_sum], ah       ; At (010E) => Sum will be 13 in hexa

    mov cl, al          ;counter register have loop branching condition that how much time loop need to be runed
    xor ah, ah          ; cleaning to register

    secondloop:
        add byte ah, [bx]
        add bx, 1
        dec cl
        jnz secondloop
    mov [second_half_sum], ah    ;at (010) => sum will be 1B in hexa

    ; Minimum Element In Array_2
    xor bx, bx          ; cleaning to register
    xor ax, ax
    xor cx, cx

    mov byte cl, [array_2_size]     ;counter register have loop branching condition that how much time loop need to be runed

    mov bx, array_2
    mov al, [bx]       ; al treated as smallest number in array in start of loop
    outerloop:
        cmp al, [bx]            ; Compare al with the value pointed by bx
        jbe skip
            mov al, [bx]       
        skip:
            add bx, 1
            dec cl
            jnz outerloop
    mov [min_array_2], al    ; Minimum Element of array_2 will be 3

    ; Greater Half of Array_1 and divide by min of Array 2
    xor ax, ax
    mov al, [first_half_sum]
    cmp al, [second_half_sum]
    jae FirstGreater
        mov al, [second_half_sum]
        mov bl, [min_array_2]
        div bl
        jmp exit

    FirstGreater:
        mov bl, [min_array_2]
        div bl
    exit:
        mov [after_div_result], al       ; 27/3 = 9 will be stored in the after_div_result label
        mov ax, 0x4c00                   ; Move 4c00 in ax register
        int 0x21                         ; OS handler see value of ax 4c00 and exit the program