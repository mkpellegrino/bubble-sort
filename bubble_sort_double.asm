	; Bubble Sort an array of floats - March 26, 2019
	; (C) 2019 - Michael K. Pellegrino
	; 64bit Assembler Library Written for MacOSX
	;
	; Parameters are: ptr to array, size of array given by: &array[sizeof(array)/sizeof(*array)]
	;
	; compile with:
	; nasm -f macho64 -g -DDEBUG -l ./bin/bubble_sort_fp_a.lst bubble_sort_fp.asm -o ./bin/bubble_sort_fp_a.o
	;
	; link with:
	; g++ -g -DDEBUG ./bin/another_object_file.o ./bin/bubble_sort_fp_a.o -o ./bin/executable_program
	;
	; in c++ code:
	; extern "C" int bubble_sort_fp(void* pBuffer, int buffer_length ); // returns how many swaps the function had to make in order to sort

[bits 64]
section .data
	buffer_start dq 0
	buffer_length dq 0

section .text
global _bubble_sort_double

_bubble_sort_double:
	push rbx
	push rcx
	push rdx
	push r9
	push r10
	push r11
	push r12
	push r13
	
	;-------------------------;
	mov rdx, rdi	          ;
	mov rdi, buffer_start	  ; store the address of buffer in "buffer_start"
	mov [rdi], rdx		  ;
	;-------------------------; 
	mov r9, rsi		  ; store the size of buffer in "buffer_length"
	mov rdi, buffer_length	  ;
	mov [rdi], r9		  ;
	;-------------------------;

	; i_limit=len-1
	dec r9			; ****

	xor r13, r13		; r13=0                  NUM_SWAPS = 0
	xor ecx, ecx		; rcx=0                  COUNTER1 = 0
label0:
	mov rdi, buffer_length	; $len -> rdi            R10=LENGTH
	mov r10, [rdi]		; [rdi]->r10

	dec r10			; ***

	sub r10, rcx		; r10-=rcx               R10-=COUNTER1
	
	xor ebx, ebx		; rbx=0                  COUNTER2=0
	mov rdi, buffer_start	; $strt -> rdi           
label1:
	mov rdx, [rdi]          ; [rdi] -> rdx           RDX= BUFFER_START

	shl rbx, 3		;
	add rdx, rbx		; rdx+=rbx               R
	shr rbx, 3
	
	mov QWORD r11,[rdx]	; [rdx] -> r11
	add QWORD rdx, 0x08		; rdx+=8
	mov QWORD r12,[rdx]	; [rdx] -> r12

;;; NOW r11 and r12 have the two FP values that I want to compare
	mov rax, 0x80000000
;;;
	cmp r11, 0
	je zero_condA
	cmp r12, 0
	je zero_condB

	cmp r11, rax
	jle one_is_neg		; if the first one is - then goto one_is_neg
	

	cmp r12, rax		; if the first one is + and
	jle do_swap		; the second one is 0 swap them
	jmp regular		; else they're both positive so cmp as normal

one_is_neg:
	cmp r12, rax		; if the first one is - and second is +
	jge skip_swap		; skip the swap
both_are_neg:
	; if we're here then they're both negative
	; reverse the swap
	cmp r11, r12		; if(r11 > r12 )
	jg skip_swap		; then DON'T SWAP
	jmp do_swap

zero_condA:
	; then r11 is 0
	; if r12 is negative then swap
	cmp r12, 0
	jl do_swap
	jmp skip_swap

zero_condB:
	; the r12 is 0
	; if r11 is positive then swap
	cmp r11, 0
	jg do_swap
	jmp skip_swap
	
	
	;;;;
regular:
;;;;;;;;;;;;;;;;;	
	cmp r11, r12		; if(r11 <= r12 )
	jle skip_swap		; then DON'T SWAP
do_swap:	
	mov QWORD [rdx], r11	; r11 -> [rdx]
	sub QWORD rdx, 0x08		; rdx-=8
	mov QWORD [rdx], r12	; r12 -> [rdx]
	inc r13			; increase the number of swaps we had to do
skip_swap:
	inc rbx			; rbx+=1
	cmp rbx, r10		; if( rbx < buffer_length )
	jl label1		; then inner loop top

	inc rcx			; rcx+=1
	cmp rcx, r9		; if( rcx < buffer_length )
	jl label0		; then top
labelX:
	mov rax, r13	       ; return the number of swaps

	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop rdx
	pop rcx
	pop rbx

	ret			; return from this function back to c++
	
_end_of_code:
