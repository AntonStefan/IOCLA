extern printf
extern puts
extern read
extern strtoul
extern calloc
extern free
extern scanf


section .rodata
  arg_fmt db "Argument is %s", 0
  hex_fmt db "Number is 0x%08x", 10, 0
  num_fmt db "%d", 0
  str_fmt db "%s", 0
  dot db ".", 0

section .text
global main

; TODO a: Implementati functia "char* read_hex_str_ip(void)" care citeste de la
;         tastatură un IP ı̂n format hex string de forma 0x8d55e076 ı̂ntr-o
;         zonă de memorie dinamică alocată pe heap ı̂n mod corespunzător.
;         Functia returnează sirul citit de la tastatură.
;
;         Apelati functia ı̂n programul principal si afisati sirul de caractere
;         citit folosind functia printf si sirul de format arg_fmt.
;
;         Indicatie: Pentru a citi de la tastatură un sir de o lungime maxima
;                    de 128 de carcatere se poate utiliza functia read a cărei
;                    apel echivalent ı̂n C este: read(0, str, 128);
;
;         Observatie: Functiile de biblioteca modifca registrele conform CDECL

read_hex_str_ip:
	push ebp
	mov ebp, esp

	push 1
	push 128
	call calloc 
	add esp, 8

	push eax

	push 128
	push eax
	push 0
	call read
	add esp, 12

	pop eax
	leave
	ret



; TODO b: Implementati functia "void convert_ip(char* hex_str, int* ptr_integer_ip)""
;         care converteste parametrul hex_str în format numeric si il salvează
;         la adresa indicată de parametrul ptr_integer_ip.
;
;         Apelati functia ı̂n programul principal furnizand ca prim argument sirul
;         citit de la tastatură, iar ca al doilea argument o adresă a unei zone
;         de memorie locale functiei main rezervată corespunzator.
;
;         Afisati valoarea stocată ı̂n zona locală de memorie utilizand functia
;         printf cu formatul de sir hex_fmt.
;
;         Indicatie: Pentru a converti un string la formatul numeric puteti
;                    utiliza functia strtoul implementand un apel echivalent cu
;                    strtoul(hex_str, NULL, 16);
;
;         Observatie: Functiile de biblioteca modifca registrele conform CDECL

convert_ip:
	push ebp
	mov ebp, esp

	mov ebx, [ebp + 12]
	mov eax, [ebp + 8]

	push 16
	push 0
	push eax
	call strtoul
	add esp, 12

	mov [ebp + 12], eax

	push eax
	push hex_fmt
	call printf
	add esp, 8

	leave
	ret


; TODO c: Implementati functia void print_ip(int integer_ip) pentru afisarea
;         adresei IP transmisă ca argument numeric functiei.
;         Fiecare octet al numărului intreg integer_ip este o parte
;         din adresa IP care apoi va fi urmată de simbolul punct (., dot) ı̂n
;         formatul dotted decimal.
;
;         Observatie: Functiile de biblioteca modifca registrele conform CDECL

print_ip:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]

loop_eax:
	xor ebx, ebx
	mo

	leave
	ret



main:
    push ebp
    mov ebp, esp

    ;TODO a: Apelati functia read_hex_str_ip si afisati sirul de caractere
    ;        citit folosind functia printf si sirul de format arg_fmt.

	call read_hex_str_ip

	push eax
	push eax
	push arg_fmt
	call printf
	add esp, 8
	pop eax

	
    ;TODO b: Apelati functia convert_ip furnizand ca prim argument sirul
    ;        citit de la tastatură, iar ca al doilea argument o adresă a unei zone
    ;        de memorie locale functiei main rezervată corespunzator.
    ;
    ;         Afisati valoarea stocată ı̂n zona locală de memorie utilizand functia
    ;         printf cu formatul de sir hex_fmt.

	sub esp, 4
	;mov ebx, esp
	push esp
	push eax
	call convert_ip
	add esp, 4

	

    ; TODO d: Apelati functia print_ip utilizand ca argument valoarea numerică
    ;         a adresei IP stocată anterior ı̂n zona locală de memorie, apoi
    ;         de-alocati corespunzator sirul de caractere citit de la tastatură.

	mov eax, [esp]
	push eax
	call print_ip
	add esp, 4
	

   
    leave
    ret
