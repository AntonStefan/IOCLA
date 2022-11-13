%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    xor edx,edx;

start:
    cmp ecx,1
    je exit
    push ecx
    mov cx,word[eax+point.x]
    mov dx,word[eax+point.x+point_size]

    cmp cx,dx;
    je ygrec

    cmp cx,dx;
    jg aici 
    jle acolo
    
aici:
    sub cx,dx;
    mov dword [ebx],ecx;
    add ebx,4
    pop ecx
    dec ecx
    add eax,point_size 
    jmp start

acolo:
    sub dx,cx;
    mov dword [ebx],edx;
    add ebx,4
    pop ecx  
    dec ecx 
    add eax,point_size
    jmp start

ygrec:
    mov cx,word[eax+point.y]
    mov dx,word[eax+point.y+point_size]
    cmp cx,dx
    jge sit1 
    jl sit2 

sit1: 
    sub cx,dx;
    mov dword [ebx],ecx;
    add ebx,4
    pop ecx
    dec ecx
    add eax,point_size
    jmp start

sit2:
    sub dx,cx;
    mov dword [ebx],edx;
    add ebx,4
    pop ecx 
    dec ecx
    add eax,point_size
    jmp start

exit:



    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY