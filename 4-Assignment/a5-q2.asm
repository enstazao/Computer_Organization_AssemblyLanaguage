SECTION .text:

GLOBAL _start

_start:
    call Print_RollNo

    ;Changing the Roll to my name
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov esi, roll_no                       ;
    push esi                               ;
    mov esi, my_name                       ;
    push esi                               ;
    mov eax, name_length                   ;
    push eax                               ;
    call Change_Roll_No_To_Name            ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov eax, 0x1
    mov ebx, 0
    int 0x80
    
    Print_RollNo:
        push eax
        push ebx
        push ecx
        push edx

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, roll_no
        mov edx, roll_no_length
        int 0x80

        pop edx
        pop ecx
        pop ebx
        pop eax
        ret

    Change_Roll_No_To_Name:
        push ebp
        mov ebp, esp
        push esi
        push ebx
        push ecx
        push edx

        mov esi, [ebp + 16]    ;roll_no
        mov ebx, [ebp + 12]    ;my_name

        mov ecx, [ebp + 8]     ;name_length
        OuterLoop:
            mov ah, [ebx]
            mov [esi], ah
            add esi, 1
            add ebx, 1
            loop OuterLoop


        mov eax, 0x04
        mov ebx, 1
        mov ecx, roll_no
        mov edx, [ebp + 8]
        int 0x80

        pop edx
        pop ecx
        pop ebx
        pop esi
        pop ebp
        ret 24
        
;.DATA section is not a typical ame for the read/write section and likely lead to the linker creating 
; the executable with .DATA being readonly.
; The read/write section is usually called .data (lowercase matters).
SECTION .data
    roll_no: db "20P-0165", 0xA, 0x0
    roll_no_length: equ $ - roll_no
    my_name: db "Jawad Ahmed", 0xA, 0x0
    name_length: equ $ - my_name