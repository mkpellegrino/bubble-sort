	; Bubble Sort an array of bytes - March 13, 2019
	; (C) 2019 - Michael K. Pellegrino
	; 64bit Assembler Library Written for MacOSX
	;
	; compile with:
	; nasm -f macho64 -g -DDEBUG -l ./bin/bubble_sort_a.lst bubble_sort.asm -o ./bin/bubble_sort_a.o
	;
	; link with:
	; g++ -g -DDEBUG ./bin/another_object_file.o ./bin/bubble_sort_a.o -o ./bin/executable_program
	;
	; in c++ code:
	; extern "C" int bubble_sort_integer(void* pBuffer, int buffer_length ); // returns how many swaps the function had to make in order to sort
[bits 64]
section .data
	buffer_start dq 0
	buffer_length dq 0

section .text
global _bubble_sort_integer

_bubble_sort_integer:
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
	mov [rdi], rdx  	  ;
	;-------------------------;
	mov r9, rsi		  ; store the size of buffer in "buffer_length"
	mov rdi, buffer_length	  ;
	mov [rdi], r9		  ;
	;-------------------------;

	; i_limit=len-1
	mov rdi, buffer_length
	mov r9, [rdi]
	dec r9

	xor r13, r13

	xor ecx, ecx

label0:
	mov rdi, buffer_length
	mov r10, [rdi]
	dec r10
	sub r10, rcx
	
	xor ebx, ebx
	mov rdi, buffer_start
label1:
	mov rdx, [rdi]

	shl rbx, 2
	add rdx, rbx
	shr rbx, 2
	
	;====
	mov r11, [rdx]
	mov rax, r11

	ror rax,0x20
	
	push rcx
	push rbx

	mov rcx, r11
	mov rbx, rax
	
	shl rcx, 0x20
	shr rcx, 0x20
	
	shl rbx, 0x20
	shr rbx, 0x20
	
	cmp ecx, ebx
	
	pop rbx
	pop rcx

	jl skip_swap
	
	mov [rdx], rax
	;====
	inc r13			; increase the number of swaps we had to do
skip_swap:
	inc rbx
	cmp rbx, r10
	jl label1
	inc rcx
	cmp rcx, r9
	jl label0
labelX:
	mov rax, r13

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
