%include "utils/printf32.asm"

extern printf

section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012


section .text
global main


main:
    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.
    mov     eax, dword 1
    shl     eax, 31

    mov     ebx, dword [val1]
    and     ebx, eax

    test    ebx, ebx
    je      unsign

sign:
    PRINTF32 `sign bit\n\x0`
    jmp     go_to_ex1b

unsign:
    PRINTF32 `no sign bit\n\x0`

go_to_ex1b:
    ; TODO b: Prin number of bits for integer value.
    mov     eax, 1
    shl     eax, 31
    xor     esi, esi

count_bits:
    mov     ebx, dword [val1]
    and     ebx, eax

    test    ebx, ebx
    je      next_bit

    inc     esi             ; nr_bits++

next_bit:
    cmp     eax, dword 1
    je      go_to_ex1c

    shr     eax, 1
    jmp     count_bits

go_to_ex1c:
    PRINTF32 `%d\n\x0`, esi

    ; TODO c: Prin number of bits for array.
    mov     ecx, len1
    mov     ebx, arr1
    xor     esi, esi


for:
    xor     eax, eax
    mov     al, byte [ebx + ecx - 1]

    xor     edx, edx
    mov     edx, 1
    shl     edx, 31

count_bits_array:
    mov     edi, eax
    and     edi, edx

    test    edi, edi
    je      next_bit_array

    inc     esi             ; nr_bits++

next_bit_array:
    cmp     edx, dword 1
    je      next_array_element

    shr     edx, 1
    jmp     count_bits_array

next_array_element:
    loop for

    PRINTF32 `%d\n\x0`, esi
    ; Return 0.
    xor eax, eax
    leave
    ret
