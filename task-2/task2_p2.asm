%include "../include/io.mac"

section .text
	global par
	extern printf

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	
	push ebp
	add esp, 8

	pop ecx							;; str_length
	pop ebx							;; str
	
	sub esp, 16						;; Pointerul revine pe ebp.

	xor edx, edx					;; Se intializeaza primul contor cu 0.
	xor eax, eax					;; Se intializeaza al doilea contor cu 0.

while_loop:

	cmp byte [ebx], '('
	je paranteza_deschisa

	inc eax							;; Creste numarul parantezelor inchise.
	jmp gata_incrementarea

paranteza_deschisa:

	inc edx 						;; Creste numarul parantezelor deschise.

gata_incrementarea:

	inc ebx							;; Se trece pe urmatorul caracter.
	loop while_loop

	cmp edx, eax					;; Se compara nr parantezelor deschise cu 
	je potrivire					;; cel al celor inchise.

	xor eax, eax					;; Rezultatul e 0.

	jmp exit1

potrivire:

	xor eax, eax
	inc eax							;; Rezultatul e 1.

exit1:

	pop ebp

	ret
