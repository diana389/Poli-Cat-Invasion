%include "../../include/io.mac"

section .text
	global sort
	extern printf

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0

	mov ecx, [ebp + 8]
	mov eax, [ebp + 12]

	sub dword ecx, 1
	mov edx, eax

	initial_leg:

		add edx, 4
		mov esi, edx
		add edx, 4
		mov [esi], edx

	loop initial_leg

	mov ecx, [ebp + 8]
	dec ecx
	mov edx, eax

	while_loop:
		
		mov ebx, edx			;; adr elem 1

	find_max:

		mov edi, ebx			;; adr x
		add edi, 4				;; adr ptr x
		mov esi, [edi]			;; ptr x
		mov edi, esi			;; ptr x
		mov esi, [edi]			;; y
		mov edi, esi			;; y

		add edx, 4
		mov esi, [edx]
		sub edx, 4

		cmp [esi], edi

		jl mai_mic

		mov ebx, edx

		mai_mic:
		
		mov edx, esi

	loop find_max

	add ebx, 4					; adr ptr x
	mov edx, [ebx]				; adr y

	add edx, 4					; adr ptr y

	mov esi, [edx]				; adr z
	sub edx, 4					; adr y
	mov [ebx], esi				; adr z

	mov esi, eax				; adr elem 1

	mov eax, edx				; adr y
	add edx, 4					; adr ptr y

	mov [edx], esi
	mov edx, eax

	mov ecx, [ebp + 8]

	parcurgere_lista:

		cmp [edx], ecx
		je gasit_max

		add edx, 4
		mov esi, [edx]
		mov edx, esi

	jmp parcurgere_lista

	gasit_max:
		mov ecx, [eax]
		dec ecx

	cmp dword ecx, 0
	jg while_loop

	leave
	ret
