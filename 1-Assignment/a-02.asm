[org 0x0100]
jmp start
    data: db 7, 5, 4, 2         ; Data need to be sorted output=> 2, 4, 5, 7
    unsort_start: db 0          ; Stores the data (number) need to be swapped with minimum number of array
    minimum_number: db 0        ; Minimum Number of Array
    check_flag: db 0            ; Check flag that swapping is happened or Not
start:
    mov cl, 4
    outerloop:

        xor si, si    ; Cleaning the register
        xor di, di
        xor ax, ax
        xor bx, bx

        mov di, data                ; di has the address of data or (7) value
        add di, [unsort_start]      ; Moving di to unsort_start location
        mov byte bh, [di]           ; Moving the unsort_start location data into the bh register
        mov byte ah, bh

        mov si, [unsort_start]              ; Let the minimum number to be first Number for comparing with the whole array     
        mov word bx, minimum_number         ; Moving the minimum_address into bx
        mov byte [check_flag], 0            ; Cleaning the check_flag register
        
        innerloop:
            cmp byte ah, [data + si]        ; Comparing the value of ah with whole array
            jbe continue
                ;else
                mov di, data
                add word di, si
                mov word bx, di           ; Location of pointing to minimum address of bx will be changed if other minimum number is found in array
                mov byte [check_flag], 1  ; Data swapped
            continue:
                inc si              ; Adding 1 in si register
                cmp si, 4           ; cmp with 4 (size of array is 4)
                jne innerloop       ; If si not reaches to 4 then restart the loop
        cmp byte [check_flag], 1    ; If another minimum data found then swap that data
        jne next
            mov di, data
            mov byte ah, [bx]
            add di, [unsort_start]
            mov byte ah, [bx]
            mov byte al, [di] 
            mov byte [di], ah
            mov byte [bx], al
        next:       ; Not found more minimum data from given let data
            inc byte [unsort_start]         ; Now the unsort_start will be changed
            dec cl                          ; subtract 1 from cl
            jnz outerloop                   ; If cl is not 0 then again jump to outer loop

    mov ax, 0x4c00  ; Move 4c00 in ax register
    int 0x21        ; OS handler see value of ax 4c00 and exit the program