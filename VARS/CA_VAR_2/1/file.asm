%include "printf32.asm"
extern printf

section .data
M dd -20
N dd 90

arr dd -30, -20, -10, 40, 50, 60, 70, 80, 90, 100
len equ 10

section .bss

; TODO b: Declarati variabla de tip `double word` cu numele `in_len`
in_len resd 1
; TODO c: Declarati vectorul de intregi (`double word`) `res` cu maximum `len` elemente
res resd len
section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Determinați cum este plasat numarul arr[0] relativ la intervalul [M, N], unde M < N. Afisati:
    ; -1, daca numarul arr[0] se afla la stanga intervalului (arr[0] < M)
    ; 0, daca numarul arr[0] se gaseste in intervalul [M, N] (M <= arr[0] <= N)
    ; 1, daca numarul arr[0] se gaseste la dreapta intervalului (arr[0] > N)

	mov eax, arr
	mov ebx, [eax]
	xor edi, edi

	cmp ebx, dword[M]
		jl modific_edi_mic
	
	cmp ebx, dword[N]
		jg modific_edi_mare
	jmp final_a

modific_edi_mic:
	mov edi, -1
	jmp final_a

modific_edi_mare:
	mov edi, 1

final_a:
	PRINTF32 `%d\n\x0`, edi

	

    ; TODO b: Calculati si afisati numarul elementelor din vectorul `arr` care se gasesc
    ; in intervalul [M, N]. Retineti aceasta valoare in variabila `in_len` din sectiunea `.bss`.

	mov eax, arr
	xor ecx, ecx
	mov edi, len

loop_b:
	mov ebx, [eax + 4 * ecx]

	cmp ebx, dword[M]
		jl scad_edi
	
	cmp ebx, dword[N]
		jg scad_edi
	jmp continui_b

scad_edi:
	dec edi

continui_b:
	inc ecx
	cmp ecx, len
		jl loop_b
	
	PRINTF32 `%d\n\x0`, edi


	
    ; TODO c: Completati vectorul `res` de dimensiune maxima `len` cu elementele din
    ; vectorul `arr` care se gasesc in intervalul [M, N].
    ; Declarati vectorul `res` in sectiunea `bss`.

	mov eax, arr
	xor ecx, ecx
	xor esi, esi
	mov ebx, res

loop_c:
	mov edx, [eax + 4 * ecx]

	cmp edx, dword[M]
		jge check_1
	
	jmp continui_c

check_1:
	cmp edx, dword[N]
		jle adaug_res
	jmp continui_c

adaug_res:
	mov [ebx + 4 * esi], edx
	inc esi

continui_c:
	inc ecx
	cmp ecx, len
		jl loop_c

	



    ; TODO d: Afisati vectorul `res` de dimensiune `in_len` cu elementele
    ; pe aceeasi linie separate de un spatiu

	xor ecx, ecx

loop_d:
	mov edx, [ebx + 4 * ecx]
	PRINTF32 `%d \x0`, edx
	inc ecx
	cmp ecx, esi
		jl loop_d
	
	PRINTF32 `\n\x0`
	

    leave
    ret
