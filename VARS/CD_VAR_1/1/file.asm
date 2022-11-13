%include "printf32.asm"

section .bss
	max resd 1
	sum resd 1
	max_pos_sum resd 1
	missing_number resd 1

section .data
	num dd 0,4,1,2
	ARRAY_SIZE equ $-num

section .text
extern printf
global main



main:

	push ebp
	mov ebp, esp

	; array size in ecx
	;PRINTF32 `%d\n\x0`, ecx

; TODO1: Aflați suma și maximul vectorului și stocați datele în variabilele 'sum', 'max'

	mov ebx, num
	mov ecx, ARRAY_SIZE
	shr ecx, 2
	dec ecx

	xor edi, edi
	xor esi, esi

loop_sum_and_max:
	mov edx, [ebx + 4 * ecx]
	add esi, edx
	cmp edx, edi
		jg modific_edi
	jmp continui_loop_a

modific_edi:
	mov edi, edx

continui_loop_a:
	dec ecx
	cmp ecx, 0
		jge loop_sum_and_max
	
	mov [sum], esi
	mov [max], edi

	PRINTF32 `Max este %d\n\x0`, [max]
	PRINTF32 `Sum este %d\n\x0`, [sum]


	mov ecx, ARRAY_SIZE
	shr ecx, 2
	;dec ecx
	xor esi, esi

loop_max_sum:
	add esi, ecx
	dec ecx
	cmp ecx, 0
		jge loop_max_sum
	
	mov [max_pos_sum], esi

	



	PRINTF32 `Max possible sum este %u\n\x0`, [max_pos_sum]


; TODO3: Aflați elementul lipsă folosind TODO1 si TODO2 și stocați-l  în 'missing number'

rez_c:
	mov ebx, [max_pos_sum]
	mov esi, [sum]

	sub ebx, esi

	mov [missing_number], ebx
	

	PRINTF32 `Missing number este %u\n\x0`, [missing_number]

	leave
	ret
