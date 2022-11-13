# Tema 1 
## add_last
Verific daca nu am primit o adresa valida. Daca *arr e NULL, 
inseamna ca array-ul e gol si trebuie inserat la inceput. Daca da
aloc memoria si copii in array headerul si continutul si 
incrementez lungimea. Daca nu e NULL, realoc si fac actiunile de mai sus.

## add_at
Verific adresa valida si index mai mare ca 0. Daca e array gol, nu
conteaza indexul si inserez la inceput. Caut cati octeti trebuie
dati skip, verific daca nu am ajuns la sfarsit si adaug la index.
Realoc, mut memoria si copii in spatiul creat.

## print_tip_i
Printez comform conditiei fiecare tip

## find
Verific bloc valid, si index mai mare ca 0. Caut indexul, daca am 
ajuns la sfarsitul memoriei nu am gasit indexul, daca nu printez

## delete_at
Verific adresa, array si index valid. Caut in array indexul si 
verific daca exista. Daca da mut memoria si realoc.

## print
Parcurg si afisez in dependenta de tip

## free_my_arr
Eliberez array-ul format in timpul programului