%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123
;;  TODO d: declare byte_array so that PRINT_HEX shows babadac
    my_array times 21 db 0
    simple_array db 1, 2, 3, 4, 5
    my_pow_array times 5 dw 0
    byte_array db 0xac, 0xad, 0xab, 0x0b
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:
    push    ebp
    mov     ebp, esp

    mov     eax, [ebp + 8]             ; eax -> char *arr
    mov     esi, [ebp + 12]            ; esi -> length

    xor     ecx, ecx                    ; left index
    mov     edi, esi                    ; right index
    dec     edi

reverse_for:
    mov     bl, byte [eax + edi]
    mov     dl, byte [eax + ecx]

    mov     byte [eax + edi], dl
    mov     byte [eax + ecx], bl

    inc     ecx
    dec     edi

    cmp     ecx, edi
    jl      reverse_for     

    leave
    ret

; TODO c: implement pow_arraypowArray
pow_array:
    push    ebp
    mov     ebp, esp

    mov     ecx, [ebp + 8]   ; a (array of bytes)
    mov     edi, [ebp + 12]  ; length
    mov     ebx, [ebp + 16]  ; b (array of words)

    xor     esi, esi
for:
    cmp     esi, edi
    jge     exit_func

    xor     edx, edx
    mov     al, byte [ecx + esi]
    mul     al

    mov     word [ebx + 2 * esi], ax

    inc     esi
    jmp     for

exit_func:

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    xor     ecx, ecx   ; ecx = index
    mov     dl, byte 'A'

construct_array:
    mov     byte [my_array + ecx], dl
    inc     dl
    inc     ecx

    cmp     ecx, 20
    jl      construct_array

    mov     byte [my_array + ecx], 0
    xor     ecx, ecx
    
    PRINTF32 `%s\n\x0`, my_array

;    ;TODO b: call array_reverse and print reversed array
    mov     eax, my_array
    mov     ecx, dword 20

    push    ecx
    push    eax
    call    array_reverse
    add     esp, 8

    PRINTF32 `%s\n\x0`, my_array

    ;TODO c: call pow_array and print the result array
    mov     eax, simple_array
    mov     ecx, dword 5
    mov     ebx, my_pow_array

    push    ebx
    push    ecx
    push    eax
    call    pow_array
    add     esp, 12

    xor     esi, esi

print_array:
    PRINTF32 `%hhu \x0`, word [ebx +  2 * esi]
    inc     esi

    cmp     esi, dword 5
    jl      print_array

	;;  TODO d: this print of an uint32_t should print babadac
    PRINTF32 `\n\x0`
	PRINTF32 `%x\n\x0`, [byte_array] 

    xor eax, eax
    leave
    ret
