extern printf
extern scanf
extern puts
extern calloc

section .rodata
  read_int_fmt: db "%d", 0
  print_int_crlf: db "%d", 0xa, 0xd, 0
  print_int_space: db "%d ", 0
  arr_fmt: db "v[%d] = ", 0
  crlf: db 0xa, 0xd, 0
  N dd 5
  N_ans dd 10
  newline db 10, 0

section .data
  test_arr dd 1, 2, 3, 4, 5
  

section .bss
  p_arr resd 1
  counter resw 1
  ans resd 10

section .text
global main

; TODO a: Implementati functia void print_int_array(int *arr, int len) care afiseaza
;         un array de intregi "arr" de lungime "len" separati prin spatiu.
;         Apoi apelati functia in programul principal pentru array-ul de test
;         "test_arr" definit in sectiunea ".data".
;         ATENTIE: Functia printf modifica o parte din registrele de uz general.

print_int_array:
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
    add esp, 8
    
    leave
    ret



; TODO b: Implementati functia void read_int_array(int *arr, int len) care citeste
;         de la inputul standard un numar de "len" valori intregi pe care le
;         depune in array-ul primit ca parametru "arr".
;         Apoi apelati functia in programul principal pentru un array de 10
;         elemente alocat pe stiva functiei "main".
;         ATENTIE: Functia scanf modifica o parte din registrele de uz general.

read_int_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]

    xor ecx, ecx

loop_read:
    lea edx, [ebx + 4 * ecx]

    push ecx
    push edx
    push read_int_fmt
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
    ;add esp, 4
    
    leave
    ret





  ; TODO c: Implementati functia int count_odd(int *arr, int len) care intoarce
  ;         ca rezultat numarul de elemente impare pentru array-ul "arr" avand lungimea
  ;         "len" primite ca parametrii.
  ;         Apoi apelati acesta functie in programul principal pentru array-ul
  ;         citit de la tastatura si afisati rezultatul

  count_odd:
      push ebp
      mov ebp, esp

      mov ebx, [ebp + 8]
      xor ecx, ecx
      xor edi, edi

loop_count:
    mov edx, [ebx + 4 * ecx]
    test edx, 1
      jz continui_count
    
    inc edi

continui_count:
    inc ecx
    cmp ecx, [ebp + 12]
      jl loop_count
    
    mov eax, edi
    leave
    ret

  






; TODO d: Implementati functia int odd_number_freq(int *arr, int len) care intoarce
;         ca rezultat frecventa (in procente) a elementelor impare din array-ul
;         "arr" avand lungimea "len" primite ca parametrii.
;         Apoi apelati acesta functie in programul principal pentru array-ul
;         citit de la tastatura si afisati rezultatul.


odd_number_freq:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 12]
    mov ecx, [ebp + 8]
    push ebx
    push ecx
    call count_odd
    add esp, 8

    mov esi, 100
    mul esi

    xor edx, edx
    mov esi, [ebp + 12]
    div esi
    

    leave
    ret




main:
    push ebp
    mov ebp, esp

    ;TODO a: Apelati functia print_int_array pentru array-ul de test "test_arr"
    ;        definit in sectiunea de date.

    push dword[N]
    push test_arr
    call print_int_array
    add esp, 8

   


    ; TODO b: Alocati un array de 10 elemente intregi pe stiva si cititi valorile
    ;         elementelor de la inputul standard folosind functia read_int_array,
    ;         apoi afisati aceste elemente utilizand functia print_int_array
    ;         Hint: puteti salva adresa array-ului alocat intr-o variabila globala

    push dword[N_ans]
    push ans
    call read_int_array
    add esp, 8

    push dword[N_ans]
    push ans
    call print_v2
    add esp, 8


    push dword[N_ans]
    push ans
    call print_int_array
    add esp, 8

   

    




    ; TODO c: Apelati functia int count_odd(int* a, int len) pentru array-ul
    ;         citit de la tastatura si afisati rezultatul obtinut.

    push dword[N_ans]
    push ans
    call count_odd
    add esp, 8

    push eax
    push print_int_space
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 8

   

   
    ; TODO d: Apelati functia int odd_number_freq(int* a, int len) pentru array-ul
    ;         citit de la tastatura si afisati rezultatul obtinut.

    push dword[N_ans]
    push ans
    call odd_number_freq
    add esp, 8

    push eax
    push print_int_space
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4

    

    leave
    ret
