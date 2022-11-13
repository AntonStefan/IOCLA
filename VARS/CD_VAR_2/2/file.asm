extern printf
extern scanf
extern malloc
extern calloc
extern free

section .rodata
  read_fmt: db "%d", 0
  print_int_crlf: db "%d", 0xa, 0xd, 0
  print_int_space: db "%d ", 0
  arr_fmt: db "v[%d] = ", 0
  freq_fmt: db "Odd Freq: %d", 0xa, 0xd, 0
  crlf: db 0xa, 0xd, 0
  newline dd 10, 0

section .data
  test_vector dd 10, 30, 31, 33, 75
  test_odd dd 13
  test_even dd 24
  ;ans dd 10
  N db 5

section .bss
  p_arr resd 1
  ans resd 10


section .text
global main

; TODO a: Implementati functia void print_vector(int *v, int len) care afiseaza
;         valorile dintr-un vector de intregi "v" de lungime "len" separate prin
;         spatiu pe o line separata.
;         Apoi apelati functia in programul principal pentru vectorul de test
;         "test_vector" definit in sectiunea ".data".
;         ATENTIE: Functia printf modifica o parte din registrele de uz general.


print_vector:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx

loop_print:
    mov edx, [ebx + 4 * ecx]

    push ecx
    push edx
    push print_int_space
    call printf
    add esp, 8

    pop ecx
    inc ecx
    cmp ecx, [ebp + 12]
      jl loop_print
    
    push newline
    call printf
    
    leave
    ret








  



; TODO b: Implementati functia int* read_vector(int len) care citeste
;         de la inputul standard un numar de "len" valori intregi pe care le
;         depune intr-un vector alocat dinamic cu aceeasi dimensiune.
;         Functia returneaza adresa catre vectorul populat catre apelant.
;
;         Apelati functia in programul principal pentru a creea un vector
;         de 10 intregi citit de la inputul standard si afisati vectorul introdus.
;         ATENTIE: Functia scanf modifica o parte din registrele de uz general.


read_vector:
    push ebp
    mov ebp, esp

    xor ecx, ecx
    mov ebx, [ebp + 8]
  
loop_read:
    xor edx, edx
    lea edx, [ebx + 4 * ecx]

    push ecx
    push edx
    push read_fmt
    call scanf
    add esp, 8

    pop ecx
    inc ecx
    cmp ecx, [ebp + 12]
      jl loop_read
    
    leave
    ret

print_v2:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx

loop_print_v2:
    mov esi, [ebx + 4 * ecx]

    push ecx
    push ecx
    push arr_fmt
    call printf
    add esp, 8

    push esi
    push print_int_space
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4

    pop ecx
    inc ecx
    cmp ecx, [ebp + 12]
      jl loop_print_v2

    ;push newline
    ;call printf
    
    leave
    ret





    


   


; TODO c: Implementati functia int is_even(int x) care returneaza 1 sau 0 daca
;         argumentul "x" este par sau respectiv, impar.
;
;         Apelati functia in programul principal pentru cele doua variabile de
;         de test "test_odd"/"test_even" definite in sectiunea de .data si afisati
;         rezultatul obtinut pentru fiecare dintre acestea pe cate o line separata.

is_even:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor eax, eax
    test ebx, 1
      jz modific_eax
    jmp final_even

modific_eax:
    mov eax, 1
final_even:
    leave
    ret








; TODO d: Implementati functia int max_even(int *v, int len) care determina
;         valoarea maxima para dintr-un vectorde valori intregi fara semn
;         si returneaza acesta valoare apelantului.
;
;         Apelati functia in programul principal pentru vectorul citit de la intrarea
;         standard, afisati rezultatul obtinut si de-alocati vectorul de intregi
;         alocat dinamic.


max_even:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor ecx, ecx
    xor edi, edi

loop_max:
    mov edx, [ebx + 4 * ecx]

    cmp edx, edi
      jg verific_par
    jmp continui_loop

verific_par:
    test edx, 1
      jz modific_edi
    jmp continui_loop

modific_edi:
    mov edi, edx

continui_loop:
    inc ecx
    cmp ecx, [ebp + 12]
      jl loop_max
    
    mov eax, edi
    leave
    ret


  


main:
    push ebp
    mov ebp, esp

    ;TODO a: Apelati functia print_vector pentru vectorul de test "test_vector"
    ;        definit in sectiunea de date.

    push dword[N]
    push test_vector
    call print_vector
    add esp, 8

    

   
    
   
    ; TODO b: Apelati functia read_vector pentru a creea un vector de 10 intregi
    ;         citit de la inputul standard. Apoi afisati valorile acestui vector
    ;         utilizand functia print_vector.
    ;         Hint: puteti salva adresa vectorului returnat de functie
    ;               intr-o variabila globala.

    push 10
    push ans
    call read_vector
    add esp, 8

    push 10
    push ans
    call print_v2
    add esp, 8

    push 10
    push ans
    call print_vector
    add esp, 8



    



    

    ;mov [ans], eax

    

    ;mov eax, ans
   


    ; TODO c: Apelati functia int is_even(int x) pentru variabilele "test_odd"/
    ;         "test_even" si afisati rezultatele obtiunte pentru fiecare pe
    ;         cate o line separata.


    push dword[test_odd]
    call is_even
    add esp, 4

    push eax
    push print_int_space
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4

    push dword[test_even]
    call is_even
    add esp, 4

    push eax
    push print_int_space
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4



    






    ; TODO d: Apelati functia max_even pentru vectorul citit de la intrarea
    ;         standard, apoi afisati rezultatul obtinut si de-alocati vectorul
    ;         de intregi.

    push 10
    push ans
    call max_even
    add esp, 4


    push eax
    push print_int_space
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4



    ; Return 0.
    xor eax, eax
    leave
    ret
