%include "printf32.asm"
extern printf

section .data
M dd -20
N dd 90

arr dd -30, -20, -10, 40, 50, 60, 70, 80, 90, 100
len equ 10

section .bss

; TODO b: Declarati variabla de tip `double word` cu numele `in_len`

; TODO c: Declarati vectorul de intregi (`double word`) `res` cu maximum `len` elemente

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Determinați cum este plasat numarul arr[0] relativ la intervalul [M, N], unde M < N. Afisati:
    ; -1, daca numarul arr[0] se afla la stanga intervalului (arr[0] < M)
    ; 0, daca numarul arr[0] se gaseste in intervalul [M, N] (M <= arr[0] <= N)
    ; 1, daca numarul arr[0] se gaseste la dreapta intervalului (arr[0] > N)



    ; TODO b: Calculati si afisati numarul elementelor din vectorul `arr` care se gasesc
    ; in intervalul [M, N]. Retineti aceasta valoare in variabila `in_len` din sectiunea `.bss`.



    ; TODO c: Completati vectorul `res` de dimensiune maxima `len` cu elementele din
    ; vectorul `arr` care se gasesc in intervalul [M, N].
    ; Declarati vectorul `res` in sectiunea `bss`.



    ; TODO d: Afisati vectorul `res` de dimensiune `in_len` cu elementele
    ; pe aceeasi linie separate de un spatiu


    ; Return 0.
    xor eax, eax
    leave
    ret
