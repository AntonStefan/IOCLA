%include "printf32.asm"

extern printf

section .bss
    results resw 9

section .data
    lap_times dw 0x37E, 0x321, 0x3FD, 0x3A5, 0x357, 0x385, 0x39B, 0x36F, 0x3E5, 0x31A
    lap_times_len equ $ - lap_times
    c_results_len equ 9
    d_results_len equ 8

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Aflați timpul minim și timpul maxim din vectorul lap_times.
    ; Salvați timpul minim pe prima poziție din vectorul results, iar timpul
    ; maxim pe cea de-a doua poziție.

       mov esi, lap_times; arr
    mov eax, 10; len
    xor ebx, ebx; min
    xor ecx, ecx; max
    xor edx, edx; aux

    mov bx, word [esi]
    mov cx, word [esi]
mloop1:
    cmp eax, 0
    je stop_mloop1

    mov dx, word [esi]

    cmp edx, ebx
    jg no_new_min
        mov ebx, edx
    no_new_min:

    cmp edx, ecx
    js no_new_max
        mov ecx, edx
    no_new_max:

    add esi, 2
    dec eax
    jmp mloop1
stop_mloop1:

    mov [results], bx
    mov [results + 2], cx




    ; Afișare rezultat pentru subpunctul a). Nu modificați!
    PRINTF32 `%hd %hd\n\x0`, word [results], word [results + 2]


    ; TODO b: Aflați câtul și restul împărțirii sumei timpilor din prima
    ; jumătate de antrenament la suma timpilor din cea de-a doua jumătate de
    ; antrenament.
    ; Salvați câtul împărțirii pe prima poziție din vectorul results, iar restul
    ; împărțirii pe cea de-a doua poziție.


    mov esi, lap_times; arr
    mov eax, 10; len
    xor ebx, ebx; first half
    xor ecx, ecx; secound half
    xor edx, edx; aux
mloop2:
    cmp eax, 5
    je stop_mloop2

    mov dx, word [esi]
    add ebx, edx
    
    add esi, 2
    dec eax
    jmp mloop2
stop_mloop2:
mloop3:
    cmp eax, 0
    je stop_mloop3

    mov dx, word [esi]
    add ecx, edx

    add esi, 2
    dec eax
    jmp mloop3
stop_mloop3:

    xor edx, edx
    mov ax, bx
    div cx

    mov [results], ax
    
    mov [results + 2], dx




    ; Afișare rezultat pentru subpunctul b). Nu modificați!
    PRINTF32 `%hd %hd\n\x0`, word [results], word [results + 2]


    ; TODO c: Aflați diferențele dintre timpi, doi câte doi.
    ; Plasați rezultatele în vectorul results.

     mov esi, lap_times; arr
    mov eax, 10; len
    mov edi, results; results arr
    xor ebx, ebx; item1
    xor ecx, ecx; item2

mloop4:
    cmp eax, 1
    je stop_mloop4

    mov bx, word [esi]
    mov cx, word [esi + 2]

    sub ebx, ecx

    mov [edi], bx

    add esi, 2
    add edi, 2
    dec eax
    jmp mloop4
stop_mloop4:



    ; Afișare rezultat pentru subpunctul c). Nu modificați!
    mov edx, results
    mov ecx, c_results_len

print_c_loop:
    PRINTF32 `%hd \x0`, word [edx]
    add edx, 2
    loop print_c_loop

    PRINTF32 `\n\x0`


    ; TODO d: Aflați în binar numărul de timpi de antrenament care au al treilea
    ; cel mai puțin semnificativ bit setat.
    ; Numărul de timpi de antrenament care au al treilea cel mai puțin
    ; semnificativ bit setat încape garantat într-un octet.
    ; Testați fiecare bit din acest număr și salvați pe poziții succesive în
    ; vectorul "results" valoarea 0 dacă bitul testat este 0, sau valoarea 1
    ; dacă bitul testat este 1.
    ; Cel mai semnificativ bit se va afla pe prima poziție din vectorul results,
    ; iar ce cel mai puțin semnificativ bit se va afla pe cea de-a opta poziție
    ; din vector.
    
    ;PRINTF32 `%d\n\x0`, edi
    
    ;mov [results], edi

  mov esi, lap_times; arr
    mov eax, 10; len
    xor ebx, ebx; counter
    xor ecx, ecx; aux
    mov edx, 0b100; mask

mloop5:
    cmp eax, 0
    je stop_mloop5

    mov cx, word [esi]

    mov edx, 0b100; mask
    and edx, ecx 

    cmp edx, 0
    je no_add
        inc ebx
    no_add:

    add esi, 2
    dec eax
    jmp mloop5
stop_mloop5:

    mov esi, results; results arr
    mov eax, 8; len
    mov edx, 0b10000000; mask

mloop6:
    cmp eax, 0
    je stop_mloop6

    mov edx, 0b10000000; mask
    and edx, ebx 
    
    cmp edx, 0
    je no_bit
    yes_bit:
        mov [esi], word 1
        jmp stop
    no_bit:
        mov [esi], word 0
    stop:

    shl ebx, 1
    add esi, 2
    dec eax
    jmp mloop6
stop_mloop6:



    ; Afișare rezultat pentru subpunctul d). Nu modificați!
    mov edx, results
    mov ecx, d_results_len

print_d_loop:
    PRINTF32 `%hd\x0`, word [edx]
    add edx, 2
    loop print_d_loop

    PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
