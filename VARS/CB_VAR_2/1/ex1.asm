%include "printf32.asm"
extern printf

section .bss
	product_answer resw 1
	answer resb 24

section .data
	playlist db 0x42, 0x75, 0x76, 0x45, 0x25, 0x79, 0x54, 0x62, 0x94, 0x35, 0x6D, 0x6E, 0x45, 0x4D, 0x7A, 0x14, 0x25, 0x57, 0x94, 0x4C, 0x55, 0x42, 0x78, 0x4B
	playlist_len equ 24

	answer_len equ 12

section .text
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a:
	; Faceti produsul dintre numarul de caractere din vector mai mici decat 'K'
	; si cel al caracterelor mai mari sau egale decat 'K'.
	; Puneti in product_answer rezultatul. (ATENTIE! product_answer asteapta
	; un word (short).eax, playlist

	mov eax, playlist
	mov ecx, playlist_len
	dec ecx

loop_a:
	mov bl, byte[eax + ecx]
	cmp bl, 'K'
		jb adun_edi
	inc esi
	jmp continui_a

adun_edi:
	inc edi

continui_a:
	dec ecx
	cmp ecx, 0
		jge loop_a
	
	mov ax, si 
	mul di

	mov [product_answer], al




	; Instructiune de afisare! NU MODIFICATI!
	a_print:
	PRINTF32 `%d\n\x0`, [product_answer]


    ; TODO b:
	; Pentru fiecare element din playlist, puneti in vectorul answer restul
	; impartirii lui la 41.

	mov ebx, playlist
	mov ecx, 0
	;dec ecx

loop_b:
	mov ebx, playlist
	xor eax, eax
	mov al, byte[ebx + ecx]

	xor edx, edx
	;xor ebx, ebx
	mov ebx, 41
	div ebx

	mov eax, answer
	mov [eax + ecx], dl
	inc ecx
	cmp ecx, playlist_len
		jl loop_b
	
	


	; Instructiune de afisare! NU MODIFICATI!
b_print:
	xor ecx, ecx
b_print_loop:
	PRINTF32 `%hhd \x0`, [answer + ecx]
	inc ecx
	cmp ecx, playlist_len
	jb b_print_loop
	PRINTF32 `\n\x0`


    ; TODO c:
	; Pentru elementele de pe indici multiplii de 3 sau de 4, inversati
	; nibbles. Fiecare rezultat va fi pus in vectorul answer.

	xor ecx, ecx
	xor edi, edi
while_loop_c:
	xor eax, eax
	mov eax, playlist
	mov bl, byte[eax + ecx]

	xor eax, eax
	xor edx, edx
	xor esi, esi

	mov eax, ecx
	mov esi, 3
	div esi

	cmp edx, 0
	je multiplu_3



	xor eax, eax
	xor edx, edx
	xor esi, esi

	mov eax, ecx
	mov esi, 4
	div esi

	cmp edx, 0
	je multiplu_4

	jmp continua_c



multiplu_3:
	;PRINTF32 `%d %d 3\n\x0`, ebx, ecx
	xor esi, esi
	mov esi, answer
	mov byte [esi + edi], bl
	inc edi
	jmp continua_c

multiplu_4:
	;PRINTF32 `%d %d 4\n\x0`, ebx, ecx
	xor esi, esi
	mov esi, answer
	mov byte [esi + edi], bl
	inc edi

continua_c:
	inc ecx
	cmp ecx, playlist_len
		jl while_loop_c





	; Instructiune de afisare! NU MODIFICATI!
c_print:
	xor ecx, ecx

c_print_loop:
	PRINTF32 `%c\x0`, [answer + ecx]
	inc ecx
	cmp ecx, answer_len
	jb c_print_loop
	PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
