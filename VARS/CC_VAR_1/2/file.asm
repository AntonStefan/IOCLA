extern strlen
extern printf
extern malloc
extern getchar
extern calloc

section .data

    n dd 99

str1 db 'Would somebody get this big walking carpet out of my way?', 0
str_fmt db '%s', 10, 0
int_fmt db '%d', 10, 0
newline db 10, 0

N equ 100
section .bss

str2 resb N

section .text
global main

; TODO b: Implementati functia void foo_gets(char *str, int size) cu urmatorul comportament:
;       - citeste cel mult `size-1` caractere de la intrarea standard si le stocheaza in memorie
;         la adresa `str`.
;       - citirea se opreste la intalnirea EndOfFile sau la intalnirea caracterului `newline`
;       - terminatorul de sir `0` se va stoca dupa ultimul caracter din sirul `str`
;       - folositi functia cu antetul in C `int getchar()` pentru a citi un caracter de la intrarea standard:
;           - getchar() intoarce urmatorul caracter din intrarea standard conertit la int
;           - getchar() intoarce 0 atunci cand se ajunge la EndOfFile
;           - getchar() intoarce 10 (decimal) atunci cand se citeste caracterul `newline`
;	ATENTIE: nu aveti voie  sa folositi apelul `fgets`.

foo_gets:
    push ebp
    mov ebp, esp

    ;mov [ebp + 8], eax
    mov ebx, [ebp + 8]
    xor ecx, ecx

loop_read:
    xor eax, eax
    push ecx
    call getchar
    pop ecx

    cmp al, 10
        je final_read
    cmp al, 0
        je final_read
    
    mov [ebx + ecx], al
    
    inc ecx
    cmp ecx, [ebp + 12]
        jl loop_read
    

final_read:
    mov eax, ebx
    ;lea [str2], eax
    leave
    ret


    







;TODO c: Implementati functia `int find_last_pos(char *str, char c)` care intoarce
;       indexul ultimei aparitii a caracterului primit in argumentul `c` din sirul
;       de caractere primit in argumentul `str`.
;       Functia intoarce -1 daca `c` nu se gaseste in `str`.

find_last_pos:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    push ebx
    call strlen
    add esp, 4

    mov ecx, eax
    dec ecx
    mov edi, -1
    mov edx, [ebp + 12]

loop_find:
    xor eax, eax
    mov al, [ebx + ecx]
    cmp al, dl 
        je modific_edi
    dec ecx
    cmp ecx, 0
        jge loop_find
    jmp final_find

modific_edi:
    mov edi, ecx

final_find:
    mov eax, edi
    leave
    ret


    



; TODO d: Implementati functia `int count_apps(char *str, char c, int l, int r)
;       care numara de cate ori apare caracterul dat de argumentul `c` in sirul `str`
;       intre pozitiile `l` si `r` (inclusiv).
;       Este garantat ca 0 <= l <= r < strlen(str)

count_apps:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 16]
    mov eax, [ebp + 8]

    xor edi, edi

loop_count:
    xor ebx, ebx
    mov bl, [eax + ecx]

    cmp bl, [ebp + 12]
        je maresc_edi
    jmp continui_d

maresc_edi:
    inc edi

continui_d:
    inc ecx
    cmp ecx, [ebp + 20]
        jle loop_count
    
    mov eax, edi
    leave
    ret






main:
    push ebp
    mov ebp, esp

    ;TODO a; Afisati la iesirea standard sirul `input_str` precum si lungimea acestuia. Fiecare afisare se va face pe o linie noua.
    ; Folositi functia de biblioteca `strlen` pentru a determina lungimea unui sir de caractere.
    ; Folositi functia `printf` pentru afisare

    push str1
    push str_fmt
    call printf
    add esp, 8

    push str1
    call strlen
    add esp, 4

    push eax
    push int_fmt
    call printf
    add esp, 8


    
    

    ;push newline
    ;call printf
    ;add esp, 4

   


;    TODO b: Apelati functia `foo_gets` pentru a citi de la intrarea standard un sir de maxim `N-1`
;           caractere pe care-l veti stoca la adresa `str2`. Afisati apoi `str2`.

    push N
    push str2
    call foo_gets
    add esp, 8

    push str2
    push str_fmt
    call printf
    add esp, 8




    ; TODO c: Functia `find_last_pos` este deja apelata mai jos
    ;   Afisati rezultatul folosind functia de biblioteca `printf`

    push 'o'
    push str1
    call find_last_pos
    add esp, 8

    push eax
    push int_fmt
    call printf
    add esp, 8

    push 'o'
    push str2
    call find_last_pos
    add esp, 8

    push eax
   push int_fmt
    call printf
    add esp, 8

    
    push 55
    push 1
    push 'o'
    push str1
    call count_apps
    add esp, 16

    push eax
    push int_fmt
    call printf
    add esp, 8

    ; print result here

    push 37
    push 3
    push 'o'
    push str2
    call count_apps
    add esp, 16

    push eax
    push int_fmt
    call printf
    add esp, 8




    ; print result here

   


    ; print result here

    ;TODO d: Functia `count_apps` este deja apelata mai jos.
    ;   Afisati rezultatul folosind functia de biblitoca `printf`

    
    xor eax, eax
    leave
    ret
