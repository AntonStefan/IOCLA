Inmultire:
    Unsigned:
        1 byte x 1 byte
        al x byte => ah:al (ax)
            
            xor eax, eax
            mov al, 100
            mov dl, 5
            mul dl
            PRINTF32 `%d\n\x0`, eax

        2 byte x 2 byte
        ax x word => dx:ax

            xor eax, eax
            mov ax, 10000
            mov dx, 500
            mul dx
            shl edx, 16
            mov dx, ax
            PRINTF32 `%d\n\x0`, edx
    
    Signed:
        - mul => imul
        -Daca vrem sa afisam trebuie sa avem
        griva la inmultirile cu rezultat negativ
        (11111111.11111111.11111111.11111110 = -2)

Impartire
    Unsigned:
        2 byte / 1 byte
        ax / byte => al rest ah

            Quotient:
                xor eax, eax
                xor edx, edx
                mov ax, 302
                mov dl, 3
                div dl
                mov dl, al
                PRINTF32 `%d\n\x0`, edx

            Reminder:
                xor eax, eax
                xor edx, edx
                mov ax, 302
                mov dl, 3
                div dl
                shr eax, 8
                PRINTF32 `%d\n\x0`, eax
        
        4 byte / 2 byte
        dx:ax / word => ax rest dx

            Quotient:
                xor eax, eax
                xor edx, edx
                xor ebx, ebx
                mov edx, 90002
                mov bx, 3
                mov ax, dx
                shr edx, 16
                div bx
                PRINTF32 `%d\n\x0`, eax

            Reminder:
                xor eax, eax
                xor edx, edx
                xor ebx, ebx
                mov edx, 90002
                mov bx, 3
                mov ax, dx
                shr edx, 16
                div bx
                PRINTF32 `%d\n\x0`, edx
    
    Signed:
        - div => idiv