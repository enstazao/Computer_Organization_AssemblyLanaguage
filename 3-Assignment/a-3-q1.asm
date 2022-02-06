[org 0x0100]
jmp start
    array_1: dw 3,8,12,3,8,15,3,2,2,11,7,3,10,5,9,6
    array_1_size: dw 16
    row_data_count: dw 0
    second_diag_sum: dw 0
    main_dia_sum: dw 0
    result: dw 0
; SubRoutine That will calculate data present At Each Row
Count_Row_Data:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx

    mov al, [bp + 4]            ; Size of the Array
    mov bh, 2

    outerloop:
        div bh                  ; divide 2 by size of array (ah=remainder, al=quotient)
        mov dh, ah              ; Remainder in dh
        mov dl, al              ; Saving First DIvison result
        mul al                  ; multiply div result with div
        cmp al, [bp + 4]        ; comparing with array size

        je mov_row_count
        ;else
        mov al, dl
        cmp dh, 1               ; Even Or ODD
        jne not_odd
            ; odd 
            dec al
        not_odd:
            jmp outerloop
    mov_row_count:
        mov byte [row_data_count], dl       ; Data At Each Row

    pop dx
    pop cx
    pop bx
    pop ax 
    pop bp
    ret 2
; SubRoutine That will calculate secondary diagnol sum
secondary_diagnol_sum:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push si

    mov si, [bp + 4]            ;Address of array
    push word [array_1_size]

    call Count_Row_Data
    mov cx, [row_data_count]        ; data present at each row
    mov ax, cx              
    shl ax, 1                       ; Because of word
    add ax, 2
    xor bx, bx
    secondary_loop:
        add dx, [si + bx]
        add bx, ax

        loop secondary_loop
    mov [second_diag_sum], dx

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 2
Calculate_Primary_Diagnol_Sum:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push si

    mov si, [bp + 4]                    ;Array Starting Location
    push word [array_1_size]

    call Count_Row_Data
    mov cx, [row_data_count]
    mov ax, [row_data_count]

    shl ax, 1                       ; because of define word
    sub ax, 2   

    mov bx, ax
    primary_loop:
        add dx, [si + bx]
        add bx, ax

        loop primary_loop
    mov [main_dia_sum], dx

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 2

diagnol_sum:
    push bp
    mov bp, sp
    push bx
    push ax

    mov bx, [bp + 4]
    push bx
    call secondary_diagnol_sum

    push bx
    call Calculate_Primary_Diagnol_Sum

    mov ax, [main_dia_sum]
    add ax, [second_diag_sum]

    mov [result], ax

    pop ax
    pop bx      
    pop bp
    ret 2           ;1Parameter is given

start:
    mov bx, array_1
    push bx
    call diagnol_sum

    mov ax, 0x4c00
    int 0x21