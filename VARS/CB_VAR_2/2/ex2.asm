extern printf
extern calloc
extern scanf

section .data
    arr dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    N dd 10
    P dd 400
    Q dd 850
    fmt_int db "%u ", 0
    fmt_newline db 10, 0
    citire_int db "%u", 0

section .text
global main

;TODO a: Implementati functia `void print_array(unsigned int *a, int N)` pentru a afisa
;   elementele vectorului `a` de dimensiune `N` pe o singura linie separate de cate un spatiu.
;
;   Afisarea se va face folosind functia `int printf(const char *format, ...);` din biblioteca standard C.
;
;   ATENTIE: Functia `printf` poate modifica registerele EAX, ECX si EDX. Pentru simplitate puteti folosi
;   instructiunile `pusha`, `popa` pentru a salva respectiv restaura toate registrele modificate de un apel de biblioteca.

print_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx

loop_print:
    xor edx, edx
    mov edx, [ebx + 4 * ecx]

    push ecx
    push edx
    push fmt_int
    call printf
    add esp, 8

    pop ecx
    inc ecx
    cmp ecx, [ebp + 12]
        jl loop_print
    
    push fmt_newline
    call printf
    add esp, 4

    mov eax, [ebp + 8]
    
    leave
    ret



;TODO b: Implementati functia `int* alloc_array(int N)` care aloca memorie (dinamic) pentru `N` intregi. Memoria alocata va trebui zeroizata.
;   Pentru alocare de memorie puteti folosi functiile:
;   - `void *malloc(int size)`, care aloca `size` octeti. Memoria alocata nu este zeroizata.
;  SAU
;   - `void *calloc(size_t nmemb, size_t size)`, care aloca `nmemb` elemente fiecare de dimensiune `size`. Memoria alocata este zeroizata.
;
;   RECOMANDARE: folositi functia `calloc`

alloc_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    push 4
    push ebx
    call calloc
    add esp, 8

    leave
    ret





;TODO c: Implementati functia `void read_array(unsigned int *a, int N)` care citeste de la intrarea standard
;   un vector `a` de `N` numere intregi fara semn.
;
;   Citirea de la intrarea standard se va face folosind functia `int scanf(const char *format, ...);` din biblioteca standard C.
;   e.g pentru citirea unui intreg
;       unsigned int elem;
;       scanf("%u", &elem);

read_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx , ecx

loop_read:
    lea edx, [ebx + 4 * ecx]

    push ecx
    push edx
    push citire_int
    call scanf
    add esp, 8

    pop ecx
    inc ecx
    cmp ecx, [ebp + 12]
        jl loop_read
    
    mov eax, [ebp + 8]
    leave
    ret





; TODO d: Implementati functia void update_interval(int *a, int N, int P, int Q)` care
;   va face urmatoarele operatii asupra sirului de elemente intregi fara semn `a` de dimensiune `N`"
;
;   a[i] = 2 * a[i], daca elementul a[i] se gaseste in intervalul [P, Q]
;   a[i] = a[i] / 2, daca elemente a[i] se gaseste in afara intervalului [P, Q]
;
; ATENTIE: este garantat ca P <= Q pentru toate apelurile functiei `update_interval`.

update_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx

loop_update:
    xor eax, eax
    mov eax, [ebx + 4 * ecx]

    cmp eax, [ebp + 16]
        jl impart_2
    cmp eax, [ebp + 20]
        jg impart_2
    
    mov esi, 2
    mul esi

    mov [ebx + 4 * ecx], eax
    jmp continui_update

impart_2:
    xor edx, edx
    mov esi, 2
    div esi
    mov [ebx + 4 * ecx], eax

continui_update:
    inc ecx
    cmp ecx, [ebp + 12]
        jl loop_update
    
    mov eax, [ebp + 8]
    leave
    ret





main:
    push ebp
    mov ebp, esp

    ; TODO a: Apelati functia `print_array(int *a, int N)` pentru a afisa vectorul `arr` de dimensiune `N` definit in sectiunea `.data`

    push dword[N]
    push arr
    call print_array
    add esp, 8

    ; TODO b: Alocati memorie pentru un vector de N intregi fara semn, apeland functia `alloc_array`
    ; si apoi afisati vectorul apeland functia `print_array`.

    push dword[N]
    call alloc_array
    add esp, 4

    



    

   


    ; TODO c: Cititi de la intrarea standard un vector de `N` intregi apeland functia `read_array`
    ; si apoi afisati vectorul folosind functia `print_array`.

    push dword[N]
    push eax
    call read_array
    add esp, 8

    push dword[N]
    push eax
    call print_array
    add esp, 8

    

    

    ; TODO d: Transformati vectorul `a` de `N` elemente intregi fara semn citit la TODO c) apeland functia
    ; `update_array` si apoi afisati vectorul folosind functia `print_array`.
    ; Functia `update_array` va fi apelata astfel:
    ; `update_array(a, N, P, Q)` unde N, P si Q se gasesc in sectiunea `.data` iar vectorul `a` este cel citit la TODO c;

    push dword[Q]
    push dword[P]
    push dword[N]
    push eax
    call update_array
    add esp, 16

    push dword[N]
    push eax
    call print_array
    add esp, 8  


    ; Return 0.
    xor eax, eax
    leave
    ret
