%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    xor edx,edx;
    xor ecx,ecx;

    mov dx,word[ebx+point.x]
    mov cx,word[ebx+point.x+point_size]

    cmp dx,cx;
    je ygrec

    cmp dx,cx;
    jg aici 
    jle acolo
    
aici:
    sub dx,cx;
    mov word [eax],dx;
    jmp exit

acolo:
    sub cx,dx;
    mov word [eax],cx;
    jmp exit

ygrec:
    mov dx,word[ebx+point.y]
    mov cx,word[ebx+point.y+point_size]
    cmp dx,cx
    jge sit1 
    jl sit2 

sit1: 
    sub dx,cx;
    mov word [eax],dx;
    jmp exit

sit2:
    sub cx,dx;
    mov word [eax],cx;
    jmp exit

exit:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY