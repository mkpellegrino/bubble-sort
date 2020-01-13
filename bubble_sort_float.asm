	; Bubble Sort an array of floats - March 28, 2019
	; (C) 2019 - Michael K. Pellegrino
	; 64bit Assembler Library Written for MacOSX
	;
	; Parameters are: ptr to array, size of array given by: &array[sizeof(array)/sizeof(*array)]
	;
	; compile with:
	; nasm -f macho64 -g -DDEBUG -l ./bin/bubble_sort_fp_a.lst bubble_sort_float.asm -o ./bin/bubble_sort_float_a.o
	;
	; link with:
	; g++ -g -DDEBUG ./bin/another_object_file.o ./bin/bubble_sort_float_a.o -o ./bin/executable_program
	;
	; in c++ code:
	; extern "C" int bubble_sort_float(void* pBuffer, int buffer_length ); // returns how many swaps the function had to make in order to sort

[bits 64]
section .data
	buffer_start dq 0
	buffer_length dq 0

section .text
global _bubble_sort_float

_bubble_sort_float:
	push rbx
	push rcx
	push rdx
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	
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

	mov rdx, [rdi]

	shl rbx, 2
	add rdx, rbx
	shr rbx, 2
	
	;====
	mov r11, [rdx]
	mov r12, r11
	
	ror r12,0x20
	mov r14, r12		; swapped value stored in r14
	
	shl r11, 0x20
	shr r11, 0x20

	shl r12, 0x20
	shr r12, 0x20


;;; === do negative tests here

	mov r15, 0x80000000
	cmp r11, r15
	jg first_is_negative

	cmp r12, r15
	jg do_swap
	jmp test_regular
	

first_is_negative:
	cmp r12, r15
	jl skip_swap
	
second_is_negative:
	cmp r12, r11
	jle skip_swap
	jmp do_swap

test_regular:
	cmp r11, r12
	jle skip_swap
	
do_swap:
	mov [rdx], r14
	;====
	
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

	pop r15
	pop r14
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
