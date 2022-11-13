%include "printf32.asm"

extern printf

section .bss
    answer resw 1

section .data
    N dd 11
    poster_arr dw 0x149, 0x2, 0x77, 0x3, 0x1DC, 0x18, 0x4D, 0x1, 0x21A, 0x3, 0xB9
    poster_len equ $ - poster_arr

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculați numărul de biți de 1 ai elementului de la mijlocul
    ; vectorului poster_arr.
    ; Salvați rezultatul în answer (un word).

    
    ;PRINTF32 `%d\n\x0`, ecx

    mov ecx, poster_len
    mov eax, poster_arr
    shr ecx, 1
    dec ecx
    shr ecx, 1
    xor edi, edi
    ;PRINTF32 `%d\n\x0`, ecx
    xor edx, edx
    mov dx, [eax + 2 * ecx]

loop_count:
    test dx, 1
        jz continui_a
    inc edi

continui_a:
    shr dx, 1
    cmp dx, 0
        jg loop_count
    








    mov [answer], di
    ; Afișare rezultat pentru subpunctul a). Nu modificați!
    PRINTF32 `%d\n\x0`, word [answer]


    ; TODO b: Identificați elementul minim din vectorul poster_arr.
    ; Salvați rezultatul în answer (un word).

    mov ecx, poster_len
    shr ecx, 1
    dec ecx
    mov edi, 10000

loop_min:
    xor edx, edx
    mov dx, [eax + 2 * ecx]
    cmp edx, edi
        jl modific_edi
    jmp continui_b

modific_edi:
    mov edi, edx

continui_b:
    dec ecx
    cmp ecx, 0
        jge loop_min
    
    mov [answer], di

    
    ; Afișare rezultat pentru subpunctul b). Nu modificați!
    PRINTF32 `%d\n\x0`, word [answer]


    ; TODO c: Calculați restul împărțirii sumei elementelor vectorului
    ; poster_arr la numărul 1337.
    ; Plasați rezultatul în answer (un word).

    mov ecx, poster_len
    shr ecx, 1
    dec ecx
    xor edi, edi

loop_sum:
    xor edx, edx
    mov dx, [eax + 2 * ecx]

    add di, dx
    dec ecx
    cmp ecx, 0
        jge loop_sum
    
    mov eax, edi
    mov esi, 1337
    xor edx, edx
    div esi

    mov [answer], dx


   


    


    ; Afișare rezultat pentru subpunctul c). Nu modificați!
    PRINTF32 `%d\n\x0`, word [answer]


    ; TODO d: Calculați produsul elementelor vectorului poster_arr de pe poziții
    ; impare.
    ; Primul element se află la index 0, produsul încape garantat pe 16 biți.
    ; Plasați răspunsul în answer (un word).

    mov ebx, poster_arr
    mov ecx, poster_len
    shr ecx, 1
    dec ecx
    mov edi, ecx
    mov ecx, 1
    mov eax, 1

loop_prod:
    xor esi, esi
    mov si, [ebx + 2 * ecx]
    xor edx, edx
    mul si

    add ecx, 2
    cmp ecx, edi
        jle loop_prod
    


   
    
    mov [answer], ax



    ; Afișare rezultat pentru subpunctul d). Nu modificați!
    PRINTF32 `%d\n\x0`, word [answer]

    ; Return 0.
    xor eax, eax
    leave
    ret
