%include "../include/io.mac"

section .text
	global cmmmc
	extern printf

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:

	push ebp
	add esp, 8

	xor edx, edx						;; Se intializeaza edx cu 0.

	pop eax								;; a
	pop ecx						     	;; b

	push ecx
	push eax
	
cmmdc:									;; Se scade numarul mai mic din cel mai mare,
										;; pana cand primul devine 0.
	cmp eax, 0				
	je exit

	cmp ecx, eax
	jle mai_mic

	sub ecx, eax
	jmp cmmdc
	
mai_mic:

	sub eax, ecx
	jmp cmmdc

exit:

	pop eax								;; eax isi reia valoarea initiala (a).
	div ecx								;; Numarul a se imparte la cmmdc.

	pop ecx								;; ecx isi reia valoarea initiala (b).
	mul ecx								;; Numarul b se inmulteste cu rezultatul anterior
										;; pentr a se obtine cmmmc.
	sub esp, 16
	pop ebp

	ret
