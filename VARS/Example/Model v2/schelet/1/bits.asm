%include "utils/printf32.asm"

section .data
    num dd 3453235129
    extern printf

section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num -> bits from the 17th and 16th position
    mov     eax, 1
    shl     eax, 17             ; eax = 2 ^ 17
    mov     ebx, [num]          ; ebx = num

    and     eax, ebx
    test    eax, eax
    je      first_zero

    jmp     first_one

first_zero:
    PRINTF32 `0\x0`
    jmp     second_byte

first_one:
    PRINTF32 `1\x0`

second_byte:
    mov     eax, 1
    shl     eax, 16             ; eax = 2 ^ 16
    mov     ebx, [num]          ; ebx = num

    and     eax, ebx
    test    eax, eax
    je      second_zero

    jmp     second_one

second_zero:
    PRINTF32 `0\n\x0`
    jmp     next

second_one:
    PRINTF32 `1\n\x0`


    ;TODO b: print number of bits set on odd positions

next:
    mov     eax, 1
    mov     ebx, [num]
    xor     esi, esi    ; number of bits set on odd position
    mov     ecx, 0

for:
    cmp     ecx, 31
    jg      print_num_of_1

    mov     edx, eax
    and     edx, ebx

    test    edx, edx
    je      next_bit

increment_num_of_1:
    inc     esi

next_bit:
    add     ecx, 2
    shl     eax, 2
    jmp     for

print_num_of_1:
    PRINTF32 `%d\n\x0`, esi

    ;TODO c: print number of groups of 3 consecutive bits set

    mov     ebx, [num]  ; num = ebx
    mov     eax, dword 7 ; 7 = 111
    mov     ecx, 2  ; position of the first bit of the group
    xor     esi,esi  ; num of groups

count_groups_of_3_bits:
    cmp     ecx, 31
    jg      print_num_of_groups

    mov     edx, eax
    and     edx, ebx

    cmp     edx, eax
    jne     next_group

add_group:
    inc     esi

next_group:
    inc     ecx
    shl     eax, 1
    jmp     count_groups_of_3_bits

print_num_of_groups:
    PRINTF32 `%d\n\x0`, esi

    xor eax, eax
    leave
    ret
