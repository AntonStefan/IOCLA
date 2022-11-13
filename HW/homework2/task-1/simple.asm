%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
    ;; Your code starts here

loopp:
   mov al, BYTE[esi];
   add al,dl;
   cmp al,'Z'
   jg rotatie

whil:
   mov BYTE [edi],al;
   add edi,1;
   add esi,1;
   loop loopp
   
   cmp ecx,0
   je exit

rotatie:
   sub al,'Z'
   sub al,1
   add al,'A';
   jmp whil

exit:

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
