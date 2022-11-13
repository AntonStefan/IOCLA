%include "../1/utils/printf32.asm"
extern malloc
extern printf

section .data
    printf_fmt_int:         db "%d ", 0
    printf_fmt_newline:     db 10, 0
    printf_fmt_int_newline: db "%d", 10, 0
    n:                      dd 5
    arr:                    dd 11, 22, 33, 44, 55

section .text
global main

print_arr:
    push ebp
    mov ebp, esp

    mov     ebx, [ebp + 8]
    mov     esi, [ebp + 12]

    xor     ecx, ecx

for:
    inc     ecx

    push    ecx
    push    dword [ebx + 4 * (ecx - 1)]
    push    printf_fmt_int
    call    printf
    add     esp, 8
    pop     ecx

    cmp     ecx, esi
    jl      for

exit: 

    ; TODO a

    leave
    ret

compute:
    push ebp
    mov ebp, esp

    ; TODO b
    xor     edx, edx
    mov     eax, [ebp + 8]
    mov     ecx, dword 9
    mul     ecx
    add     eax, dword 10

    leave
    ret

new_array:
    push ebp
    mov ebp, esp

    ; TODO c
    mov     ecx, [ebp + 8]

    xor     edx, edx
    mov     eax, dword 4
    mul     ecx

    mov     ecx, eax
    xor     eax, eax
    xor     edx, edx

    push    ecx
    call    malloc
    add     esp, 4

    mov     [eax], dword 1

    mov     ecx, [ebp + 8]
    xor     esi, esi

create_array:
    push    ecx
    push    eax
    push    esi
    call    compute
    add     esp, 4
    mov     ebx, eax
    pop     eax
    pop     ecx

    mov     dword [eax + 4 * esi], ebx
    inc     esi

    cmp     esi, ecx
    jle     create_array

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    ; call print_arr
    push    dword [n]
    push    arr
    call    print_arr
    add     esp, 8

    push printf_fmt_newline
    call printf
    add esp, 4

    ; OUTPUT:
    ; 11 22 33 44 55

    ; TODO b
    push dword[n]
    call compute
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 100
    call compute
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 55
    ; 910

    ; TODO c
    ; call new_array(11)
    ; call print_arr

    push    dword 11
    call    new_array
    add     esp, 4

    push    dword 11
    push    eax
    call    print_arr
    add     esp, 8

    push printf_fmt_newline
    call printf
    add esp, 4

    ; OUTPUT:
    ; 10 19 28 37 46 55 64 73 82 91 100


    xor eax, eax
    leave
    ret
