SECTION .text:

GLOBAL _start

_start:
    call Print_Message
    ;Calling the Summation function that takes two parameters
    ;;;;;;;;;;;;;;;;;;;;;;;
    mov eax, [a]          ;
    push eax              ; 
    mov ebx, [b]          ;
    push ebx              ;
    call sum              ;
    ;;;;;;;;;;;;;;;;;;;;;;;

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;ecx have the result   ;
    push ecx               ;
    call Print_Result      ;
    ;;;;;;;;;;;;;;;;;;;;;;;;

    ; exit the program 
	mov eax, 0x1 				; exit system call is 0x1 
	mov ebx, 0 					; exit code is 0 (return 0) 
	int 0x80 					; Comment out and see!  

    sum:
        push ebp
        mov ebp, esp
        push eax
        push ebx
        push ecx

        xor ecx, ecx
        mov eax, [ebp + 12]
        mov ebx, [ebp + 8]
        add eax, ebx         ;a + b
        mov ecx, eax

        pop eax
        pop ebx
        pop eax
        pop ebp
        ret 8       ;2 parameters

    Print_Message:
        push eax
        push ebx
        push ecx
        push edx

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, message
        mov edx, message_length
        int 0x80

        pop edx
        pop ecx
        pop ebx
        pop eax
        ret

    Print_Result:
        push ebp
        mov ebp, esp
        push eax
        push ebx
        push ecx
        push edx
        push esi

        mov eax, [ebp + 8]          ;Number To Print
        mov bx, 10
        mov cx, 0
        nextdigit:
            mov dx, 0
            div bx
            add dx, 0x30
            push edx
            inc cx
            cmp ax, 0
            jnz nextdigit
        mov esi, num
    
        nextpos:
            pop edx
            mov [esi], dl
            add esi, 1
            loop nextpos

        add si, 1
        mov byte [esi], 0xA
        add si, 1
        mov byte [esi], 0x0

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, num
        mov edx, num_length
        int 0x80

        pop esi
        pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        ret 4
;.DATA section is not a typical ame for the read/write section and likely lead to the linker creating 
; the executable with .DATA being readonly.
; The read/write section is usually called .data (lowercase matters).
SECTION .data
    a DD 1000
    b DD 6000

    message: db "Result=> ", 0x0 
	message_length: equ $-message 

    num: db "0          ", 0xA, 0x0
    num_length: equ $ - num    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;end;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
