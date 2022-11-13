%include "printf32.asm"

extern printf

struc elev
    .nume: resb 20
    .nota: resd 1
endstruc

section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012
    x dd 100
    n dd 10

Sorin:
    istruc elev
        at elev.nume, db 'Anton Stefan', 0
        at elev.nota, dd 10
    iend

section .text
global main

sum:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; primul parametru
    mov ebx, [ebp + 12] ; al doilea parametru
    
    ;Instructiuni...

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ;   Folosire macro PRINTF32
    ;PRINTF32 `%d\n\x0`, eax
    
    ;   Exemplu apelare functie
    
    mov eax, 1
    mov ebx, 2
    ;   Punere pe stiva in ordine inversa
    push ebx
    push eax
    call sum
    add esp, 8


    ; Return 0.
    xor eax, eax
    leave
    ret