%include "utils/printf32.asm"

extern strlen
extern printf


section .rodata
    test_str db "hell, it's about time", 0
    format db "length = %d", 10, 0

section .text
global main

recursive_strlen:
    push    ebp
    mov     ebp, esp

    mov     edx, [ebp + 8]

    cmp     byte [edx], byte 0
    jle     exit

    inc     eax

call_recursive_strlen:
    inc     edx

    push    edx
    call    recursive_strlen
    add     esp, 4

exit:
    leave
    ret

main:
    push ebp
    mov ebp, esp

    push test_str
    call strlen
    add esp, 4

    push eax
    push format
    call printf
    add esp, 8


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.
    xor     eax, eax
    mov     ecx, test_str

    push    ecx
    call    recursive_strlen
    add     esp, 4

    push    eax
    push    format
    call    printf
    add     esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
