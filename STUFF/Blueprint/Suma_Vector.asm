%include "printf32.asm"

extern printf

; definita structurii

section .data
    arr1 db 1, 2, 3, 4, 5

section .text
global main

sum:
    push ebp
    mov ebp, esp
    

    mov ebx, [ebp + 8]; arr1
    mov ecx, [ebp + 12]; len

    xor eax, eax
    xor edx, edx
loop:
    test ecx, ecx
    je end_loop

    mov dl, byte [ebx]
    add al, dl

    inc ebx
    dec ecx
    jmp loop
end_loop:


    leave
    ret

main:
    push ebp
    mov ebp, esp
    

    xor eax, eax
    mov ebx, arr1
    mov ecx, 5 ; len
    push ecx
    push ebx
    call sum
    pop ebx
    pop ecx

    PRINTF32 `%d\n\x0`, eax


    leave
    ret