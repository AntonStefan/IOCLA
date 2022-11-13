%include "printf32.asm"

section .bss
	index resd 1
	result resd 0
	;N db 7

section .data
	string db "abcdefd", 0
	STRING_SIZE equ $-string
	chr db 'd'
	N db 7


section .text
extern printf
global main

main:

	push ebp
	mov ebp, esp

; TODO1: Aflați indexul primei apariții a caracterului in string și afișați-l

	xor ecx, ecx
	mov ebx, string
	mov edi, -1
	mov eax, [chr]

loop_a:
	xor edx, edx
	mov dl, [ebx + ecx]

	cmp dl, al
		je modific_edi
	inc ecx
	cmp ecx, dword[N]
		jl loop_a
	jmp final

modific_edi:
	mov edi, ecx

final:


	PRINTF32 `Indexul este %d\n\x0`, edi

	

; TODO2: Înlocuiți toate aparițiile caracterelor din intervalul [0:index] cu rot13 și afisați-l în această formă

		xor ecx, ecx
loop_b:
	xor edx, edx
	mov dl, [ebx + ecx]

	add dl, 13
	cmp dl, 'z'
		jg scad_26
	jmp continui_b

scad_26:
	sub dl, 26

continui_b:
	mov [ebx + ecx], dl
	inc ecx
	cmp ecx, edi
		jle loop_b


	
	PRINTF32 `Stringul este  %s\n\x0`, string

; TODO3: Faceți reversul stringului și afișați-l
	
	xor esi, esi
	mov edi, dword[N]
	sub edi, 1

loop_c:
	xor edx, edx
	mov dl, [ebx + esi]

	xor eax, eax
	mov al, [ebx + edi]

	mov [ebx + esi], al
	mov [ebx + edi], dl

	inc esi
	dec edi
	cmp esi, edi
		jl loop_c



	PRINTF32 `Stringul inversat este %s\n\x0`, string


    leave
    ret
