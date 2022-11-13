%include "printf32.asm"
extern printf
extern calloc

section .data

M dw 1000
N dw 700

arr1 dw 1000, 1000, 30, 40, 50, 60, 70, 80, 90, 100
arr2 dw 90, 100, 90, 50, 40, 30, 20, 10, 60, 100
len equ 10

result dd 0

section .bss
    ans dd 10

; TODO c: Alocati memorie pentru vectorul `res` cu elemente de tip double word si dimensiunea egala cu `len`

section .text

global main

constructie_ans:
    push ebp
    mov ebp, esp

    xor ecx, ecx

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]


loop_constructie:
    xor ebx, ebx
    mov bx, [esi + 2 * ecx]

    xor edx, edx
    mov dx, [edi + 2 * ecx]

    xor eax, eax
    mov ax, bx
    mul dx

    xor ebx, ebx
    mov ebx, [ebp + 16]
    mov [ebx + 4 * ecx], ax
    mov [ebx + 4 * ecx + 2], dx

    inc ecx
    cmp ecx, [ebp + 20]
        jl loop_constructie
    
    mov eax, [ebp + 16]
    
    leave
    ret







main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculati si afisati produsul numerelor reprezentate pe 2 octeti (word) M si N.
    ; Sugestie: Pentru inmultire puteti folosi instructiunea `mul` care:
    ;   - primeste primul operand in registrul AX
    ;   - primeste al doilea operand intr-un registru pe 16 biti / memorie de 16 biti
    ;   - intoarce rezultatul in DX:AX
    ;   - pe scurt, DX : AX = AX * r/m16.

    xor eax, eax
    xor esi, esi
    mov si, word[N]
    mov ax, word[M]
    mul si

    mov [result], ax
    mov [result + 2], dx

    mov eax, [result]

    PRINTF32 `%d\n\x0`, eax

    ; TODO b: Calculati si afisati produsul scalar al vectorilor arr1 si arr2
    ;   - P = arr1[0] * arr2[0] + arr1[1] * arr2[1] + ... arr1[i] * arr2[i] + ...
    ;   - este garantat ca P nu depaseste dimensiunea unui double word (4 octeti)

    mov ebx, arr1
    mov ecx, arr2

    xor esi, esi
    xor edi, edi

loop_b:
    push edi
    mov ax, [ebx + 2 * esi]
    mov di, [ecx + 2 * esi]
    mul di

    mov [result], ax
    mov [result + 2], dx
    mov eax, [result]
    mov[ans + 4 * esi], eax
    pop edi
    add edi, eax
    inc esi
    cmp esi, 10
        jl loop_b
    
    PRINTF32 `%d\n\x0`, edi

    xor ecx, ecx
    mov ebx, ans

afis_ans:
    mov eax, [ebx + 4 * ecx]
    PRINTF32 `%d \x0`, eax
    inc ecx
    cmp ecx, 10
        jl afis_ans
    PRINTF32 `\n\x0`








    





    ; TODO c: Completati vectorul `res` cu elemente de tip double word de dimensiune `len`  astfel incat
    ; fiecare element sa fie egal cu produsul elementelor corespunzatoare din vectorii `arr1` si `arr2`.
    ; - e.g: res[i] = arr1[i] * arr2[i]




    ; TODO d: Afisati vectorul `res` cu elemente de tip double word de dimensiune `len` calculat la punctul c)




    ; Return 0.
    xor eax, eax
    leave
    ret
