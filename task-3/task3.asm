%include "../../include/io.mac"

global get_words
global compare_func
global sort
global maria
global qsort

section .text
	extern printf

compare_func:
    enter 0, 0

	mov edx, [ebp + 8]
    mov ebx, [edx]                          ;; primul sir
    mov edx, [ebp + 12]
    mov ecx, [edx]                          ;; al doilea sir

    xor eax, eax                            ;; nr de caractere al primului sir

in_word1:

    cmp byte [ebx], 0                       ;; Se compara cu '\0'.
    je end_of_word1

    inc eax                                 ;; Creste nr de caractere.
    inc ebx                                 ;; Se trece pe caracterul urmator.

    jmp in_word1

end_of_word1:

    xor edx, edx                            ;; nr de caractere al celui de-al doilea sir

in_word2:

    cmp byte [ecx], 0                       ;; Se compara cu '\0'.
    je end_of_word2

    inc edx                                 ;; Creste nr de caractere.
    inc ecx                                 ;; Se trece pe caracterul urmator.

    jmp in_word2

end_of_word2:

    cmp eax, edx
    jne not_equal
                                           ;; Nr de caractere al sirurilor este egal.
	mov edx, [ebp + 8]
    mov ebx, [edx]

    mov edx, [ebp + 12]
    mov ecx, [edx]

    push ecx
    push ebx

    extern strcmp
    call strcmp                             ;; Se compara sirurile lexicografic.     

    add esp, 8

    jmp exit

not_equal:                                  ;; Nr de caractere al sirurilor este diferit.

    sub eax, edx

exit: 

    leave
    ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0

	mov ebx, [ebp + 8]                      ;; words
    mov ecx, [ebp + 12]                     ;; number_of_words
    mov edx, [ebp + 16]                     ;; size
    
    push dword compare_func
    push edx
    push ecx
    push ebx

    extern qsort
    call qsort                              ;; Se sorteaza matricea.

    add esp, 16

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0

    mov eax, [ebp + 8]                      ;; s
	mov ebx, [ebp + 12]                     ;; words
    mov ecx, [ebp + 16]                     ;; number_of_words

    mov edx, [ebx]                          ;; pointer catre primul caracter
 
in_word:
    
    cmp byte [eax], 32                      ;; Se compara cu ' '.
    je end_of_word

    cmp byte [eax], 44                      ;; Se compara cu ','.
    je end_of_word

    cmp byte [eax], 46                      ;; Se compara cu '.'.
    je end_of_word

    cmp byte [eax], 10                      ;; Se compara cu '\n'.
    je end_of_word

    cmp byte [eax], 0                       ;; Se compara cu '\0'.
    je end_of_word

    mov edi, [eax]
    mov [edx], edi

    inc edx
    inc eax                                 ;; Se trece la urmatorul caracter.

    jmp in_word

end_of_word:

    mov byte [edx], 0                       ;; Se adauga caracterul null la final.
    inc eax                                 ;; Se trece la urmatorul caracter.

    cmp byte [eax], 32                      ;; Se compara cu ' '.
    je end_of_word

    cmp byte [eax], 44                      ;; Se compara cu ','.
    je end_of_word

    cmp byte [eax], 46                      ;; Se compara cu '.'.
    je end_of_word

    cmp byte [eax], 10                      ;; Se compara cu '\n'.
    je end_of_word

    cmp byte [eax], 0                       ;; Se compara cu '\0'.
    je end_of_word

    add dword ebx, 4                        ;; Se trece la urmatorul sir din matrice.
    mov edx, [ebx]                          ;; pointer catre primul caracter

    loop in_word
    
    leave
    ret
