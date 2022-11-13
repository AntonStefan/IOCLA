extern stdin

extern printf
extern scanf
extern calloc
extern strlen

section .data
str_fmt db '%s', 0
char_fmt db '%c', 0
str_fmt_newline db '%s', 10, 0
int_fmt_newline db '%d', 10, 0
N dd 64

section .text
global main

;TODO a: Implementati functia `char* read_string(void)` cu urmatorul comportament:
;   - functia aloca memorie pentru a stoca cel mult `N` octeti initializati cu 0.
;   - functia citeste de la intrarea standard un sir de caractere de dimensiune cel mult `N-1` si il stocheaza in memoria alocata.
;   - functia intoarce adresa de memorie alocata mai sus.
;   - pentru alocarea de memorie se recomanda folosirea functiei `void *calloc(size_t nmemb, size_t size);` din biblioteca standard.
;   - pentru citirea de la intrarea standard se recomanda folosirea functiei `int scanf(const char *format, ...);`

read_string:
    push ebp
    mov ebp, esp

    push 1
    push dword[N] 
    call calloc
    add esp, 8

    push eax
    push eax
    push str_fmt
    call scanf
    add esp, 8

    pop eax
    leave
    ret
 




; TODO b: Implementati functia `int is_vowel(char c)` care ne spune daca un caracter este vocala sau nu.
;   - functia intoarce 1 daca caracterul primit ca parametru este vocala si 0 in rest.
;   - vocalele sunt `aeiou`.
;   - puteti folosi functia de biblioteca `strlen` pentru a determina dimensiunea unui sir de caractere.
;   - este garantat ca parametrul de intrare va fi o litera mica a alfabetului englezesc.

is_vowel:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 'a'
        je pun_1
    cmp eax, 'e'
        je pun_1
    cmp eax, 'i'
        je pun_1
    cmp eax, 'o'
        je pun_1
    cmp eax, 'u'
        je pun_1
    mov eax, 0
    jmp final_voc

pun_1:
    mov eax, 1

final_voc:
    leave
    ret


; TODO c: Implementati functia `void replace_vowels(char *s)` care inlocuieste toate vocalele din sirul primit
;   la intrare cu caracterul 'X'
;   - functia va modifica sirul de intrare
;   - sirul de intrare este compus doar din litere mici ale alfabetului englezesc


replace_vowels:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    push ebx
    call strlen
    add esp, 4

    mov ecx, eax
    dec ecx

loop_replace:
    xor edx, edx
    mov dl, [ebx + ecx]

    push ecx
    push edx
    call is_vowel
    add esp, 4

    pop ecx

    cmp eax, 1
        je replace_X
    jmp continui_replace

replace_X:
    xor edx, edx
    mov edx, 'X'
    mov [ebx + ecx], dl
    ;mov [ebx + ecx], edx

continui_replace:
    dec ecx
    cmp ecx, 0
        jge loop_replace
    
    mov eax, ebx
    leave
    ret




;TODO d: Implementati functia `int is_palindrome(char *s)` care ne spune daca un sir este palindrom sau nu.
;   - un sir este palindrom daca citit de la dreapta la stanga sau de la standa la dreapta ramane neschimbat.
;   - functia va intoarce 1 daca sirul este palindrom si 0 in rest

is_palindrome:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    push ebx
    call strlen
    add esp, 4

    mov edi, eax
    dec edi
    xor esi, esi
    ;xor edi, edi

loop_palindrome:
    xor edx, edx
    xor ecx, ecx
    mov dl, [ebx + esi]
    mov cl, [ebx + edi]

    cmp dl, cl
        jne pun_0
    inc esi
    dec edi
    cmp esi, edi
        jl loop_palindrome
    mov eax, 1
    jmp final

pun_0:
    mov eax, 0
final:
    leave
    ret


main:
    push ebp
    mov ebp, esp

    ; Rulati ./file < input.txt pentru o testare completa

    ; TODO a: Apelati functia `read_string` pentru a citi un sir de caractere de la intrarea standard si afisati-l!
    ; pentru afisare puteti folosi functia `printf`.
    ; ATENTIE: functia `printf` poate sa modifice anumite registre. puteti salva / restaura toate registrele folosind instructiunile `pusha`/`popa`

    xor eax, eax
    call read_string
    push eax
    push str_fmt_newline
    call printf
    add esp, 8

    ; TODO b: Decomentati apelurile functiei `is_vowel` si afisati rezultatul intors. Acesta ne spune daca argumentul este vocala sau nu.

    push 'a'
    call is_vowel
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8

    push 'b'
    call is_vowel
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8


    ; TODO c: Citi de la intrarea standard un sir de caractere si apelati functia `replace_vowels` pentru a marca
    ; cu caracterul `X` toate vocalele. Afisati apoi sirul rezultat.
    call read_string
    push eax
    call replace_vowels
    add esp, 4

    push eax
    push str_fmt_newline
    call printf
    add esp, 8




    ; TODO d: Testati implementarea functiei `is_palindrome` folosind ca intrare doua siruri de caractere citite de la intrarea standard.
    ; Exemplu:
    ; test #1
    call read_string
    push eax
    call is_palindrome
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8

    call read_string
    push eax
    call is_palindrome
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8

    ; call is_palindrome
    ; call printf ; to print result
    ; test #2
    ; call read_string
    ; call is_palindrome
    ; call printf; to print result


    ; Return 0.
    xor eax, eax
    leave
    ret
