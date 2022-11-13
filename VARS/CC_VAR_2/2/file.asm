extern printf
section .data

arr dd  1331, 1441, 1551, 1661, 1771, 1881, 1991, 2002, 2022, 1337
len equ 10
N dd 10
int_fmt db '%d ', 0
int_fmt_newline db '%d', 10, 0
NEWLINE db 10, 0

TEN     dd 10

section .bss
ans resd len

section .text
global main

; TODO a: Implementati functia `void print_array(int *arr, int n) care afiseaza
;   elementele numere intregi ale vectorului `arr` de dimensiune n.
;   Toate elementele vor fi afisate pe aceeasi linie separate de un spatiu.
;   La finalul afisarii se va insera NEWLINE. Vezi sectiunea .data
;   functia `printf` poate modifica registrele EAX, ECX si EDX.

print_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    xor ecx, ecx
loop_print:
    mov eax, [ebp + 8]
    mov ebx, [eax + 4 * ecx]

    push ecx
    push ebx
    push int_fmt
    call printf
    add esp, 8
    pop ecx

    inc ecx
    cmp ecx, [ebp + 12]
        jl loop_print
    
    push NEWLINE
    call printf
    add esp, 4
    
    leave
    ret




;TODO b: Implementati functia `int sum_digits(n)` care intoarce suma cifrelor numarului
;   intreg fara semn `n`.
;   e.g:
;       -sum_digits(123456) = 1+2+3+4+5+6 = 21
;       -sum_digits(100) = 1+0+0 = 1

sum_digits:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx
    xor esi, esi

loop_sum:
    mov eax, ebx
    xor edx, edx
    mov edi, 10
    div edi

    add esi, edx

    mov ebx, eax
    cmp ebx, 0
        jg loop_sum
    
    mov eax, esi
    leave
    ret





; TODO c: Implementati functia `void sum_digits_arr(int *arr, int len, int *out_arr)
; care actualizeaza fiecare element din vectorul `out_arr` cu suma cifrelor elementului
; corespunzator din vectorul `arr` de dimensiunea `len`.
; out_arr[i] = sum_digits(arr[i])
; ATENTIE la registrii pe care functia `sum_digits` ii modifica.

sum_digits_arr:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx

loop_sum_arr:
    mov ebx, [ebp + 8]
    mov edx, [ebx + 4 * ecx]

    push ecx
    push edx
    call sum_digits
    add esp, 4
    pop ecx

    mov edx, [ebp + 16]
    mov [edx + 4 * ecx], eax

    inc ecx
    cmp ecx, [ebp + 12]
        jl loop_sum_arr
    
    leave
    ret


;TODO d: Implementati functia `int reverse(int a)` care intoarce rasturnatul
; unui numar intreg fara semn. Rasturnatul este numarul obtinut din citirea
; numarului initial de dreapta la stanga.
; e.g:
;       - reverse(123456) = 654321
;       - reverse(300000) = 3
;       - reverse(10002)  = 20001

reverse:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor esi, esi

loop_reverse:
    mov eax, ebx
    xor edx, edx
    mov ecx, 10
    div ecx

    mov ebx, eax
    mov ecx, edx

    mov eax, esi
    mov edi, 10
    mul edi

    add eax, ecx
    mov esi, eax

    cmp ebx, 0
        jg loop_reverse
    
    mov eax, esi
    
    leave
    ret




main:
    push ebp
    mov ebp, esp

    ;TODO a: Afisati folosind functia `print_array` vectorul `arr` de dimensiune `len`.
    push dword[N]
    push arr
    call print_array
    add esp, 8



    ;TODO b: Apelati functia `sum_digits` pentru numerele intregi `123456` si `202020`. Afisati rezultatul
    ;folosind functia `printf`. Fiecare rezultat fiind afisat pe o linie noua.


    push 123456
    call sum_digits
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8



    push 202020
    call sum_digits
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8




    ; TODO c: Apelati functia `sum_digits_arr` pentru a calcula suma cifrelor numerelor din vectorul `arr` de dimensiune `len`.
    ; Salvati rezultatul in vectorul `ans` alocat in sectiunea `.bss`
    ; Afisati apoi vectorul `ans` folosind functia `print_array` implementata la TODO a.

    push ans
    push dword[N]
    push arr
    call sum_digits_arr
    add esp, 12

    push dword [N]
    push ans
    call print_array
    add esp, 8


    ; TODO d: Apelati functia `reverse` pentru a calcula rasturnatul numerelor intregi fara semn `123456` si `100`. Afisati
    ; apoi fiecare rezultat pe o linie noua.

    push 123456
    call reverse
   add esp, 4

    push eax
    push int_fmt_newline
    call printf
   add esp, 8



    push 100
    call reverse
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8



    xor eax, eax
    leave
    ret
