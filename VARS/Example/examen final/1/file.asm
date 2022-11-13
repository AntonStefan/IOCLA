%include "utils/printf32.asm"
extern printf

section .data

M dd 0x21122112
mask db 0x12

arr dd 0x12345678, 0x12121212, 0x42424242, 0x12771277, 0xCAFEBABE, 0x12001200, 0x20222022, 0x03020302, 0x12FF12FF, 0xFF12FF12
len equ 10
res times 10 dd 0

;TODO c: Declarati vectorul de intregi (double word) `res` cu dimensiunea egala cu `len`

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculați și afișati numărul de biți `1` din numărul întreg `M`.
    ; Numărul `M` este definit în secțiunea `.data`.

    mov     eax, [M]

    mov     ebx, 1
    mov     ecx, 31
    xor     esi, esi

count_bits:
    mov     edx, eax

    and     edx, ebx
    test    edx, edx
    je      next

    inc     esi

next:
    shl     ebx, 1
    loop count_bits

    PRINTF32 `%d\n\x0`, esi

    ; TODO b: Calculați și afișati numărul de octeți egali cu `mask` din numărul întreg `M`.
    ; Numerele `M` și `mask` sunt definite în secțiunea `data`

    xor     ebx, ebx
    mov     eax, [M]
    xor     esi, esi
    mov     bl, byte [mask]
    mov     edi, 255
    mov     ecx, 4

count_bytes:
    mov     edx, eax

    and     edx, edi
    cmp     edx, ebx
    jne     next_count_bytes

    inc     esi

next_count_bytes:
    shl     ebx, 8
    shl     edi, 8
    loop    count_bytes

    PRINTF32 `%d\n\x0`, esi

    ; TODO c: Completați vectorul `res` de dimensiune `len` astfel:
    ;   - fiecare element res[i] este egal cu numărul de octeți din arr[i] ce au valoarea `mask`

    mov     edx, 0

for:
    mov     eax, dword [arr + 4 * edx]
    xor     esi, esi
    mov     bl, byte [mask]
    mov     edi, 255
    
    mov     ecx, 4

count_bytes_arr:
    push    edx
    mov     edx, eax

    and     edx, edi
    cmp     edx, ebx
    jne     next_count_bytes_arr

    inc     esi

next_count_bytes_arr:
    pop     edx
    shl     ebx, 8
    shl     edi, 8
    loop    count_bytes_arr

    mov     dword [res + 4 * edx], esi

    cmp     edx, len
    jge     exit_count_bytes

    inc     edx

    jmp     for

exit_count_bytes:

    ; TODO d: Afișați vectorul `res` de dimensiunea `len` completat cu elementele definite la punctul c)
    mov     ecx, 0

print_res:
    PRINTF32 `%d \x0`, [res + 4 * ecx]
    inc     ecx

    cmp     ecx, len
    jge     exit 

    jmp print_res

exit:

    ; Return 0.
    xor eax, eax
    leave
    ret
