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
	; extern "C" int bubble_sort_character(void* pBuffer); // returns how many swaps the function had to make in order to sort
[bits 64]
section .data
	buffer_start dq 0
	buffer_length dq 0

section .text
global _bubble_sort_character

_bubble_sort_character:
	push rbx

	;-----------------------;
	mov rdx, rdi
	mov rdi, buffer_start	; store the address of buffer in "buffer_start"
	mov [rdi], rdx		;
	;-----------------------;

	db 0x50, 0x51, 0x52, 0x57 ; push registers
	mov rdi, buffer_start
	mov rax, [rdi]
	mov rdi, rax
	call _get_length	; Get the length of the buffer
	db 0x5F, 0x5A, 0x59, 0x58 ; pop registers

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
	add rdx, rbx

	mov al,[rdx]
	inc rdx
	mov ah,[rdx]

	cmp al, ah
	jle skip_swap
	mov [rdx], al
	dec rdx
	mov [rdx], ah
	inc r13			; increase the number of swaps we had to do
skip_swap:
	inc rbx
	cmp rbx, r10
	jl label1
	inc rcx
	cmp rcx, r9
	jl label0
labelX:


	pop rbx
	mov rax, r13
	
	ret			; return from this function back to c++
	

_swap:				; This swaps two elements in the buffer
	;                       ; (buffer[r9] with buffer[r10])
	;-----------------------;
	mov rax, rdi		; store the address of buffer in "buffer_start"
	mov rdi, buffer_start	;
	mov [rdi], rax		;
	;-----------------------;

	mov r9, rsi
	mov r10, rdx

	;xor rax, rax
	;xor rdx, rdx
	xor eax,eax
	xor edx,edx
	
	mov rdx, [rdi]
	mov rdi, rdx
	mov BYTE al, [rdi+r9]
	mov BYTE dl, [rdi+r10]
	mov BYTE [rdi+r10], al
	mov BYTE [rdi+r9], dl
	ret

_get_length:
	;-----------------------;
	mov rax, rdi		; store the address of buffer in "buffer_start"
	mov rdi, buffer_start	;
	mov [rdi], rax		;
	;-----------------------;		
	;                       ; First, let's get the length of the buffer
	xor ecx,ecx
getlen:
	mov BYTE dl, [rax+rcx]
	cmp dl, 0x00		; a null byte ends the buffer, so cmp dl with 0x00
	je endlen		; to find the end
	inc rcx
	jmp getlen
endlen:	mov rdi, buffer_length
	mov [rdi], rcx
	mov rax, rcx
	ret

_dump:	
	; Display Buffer
	mov rax, 0x2000004 ; write
	mov rdi, 0x01
	mov rdx, buffer_start
	mov rsi, [rdx]
	mov rbx, buffer_length
	mov rdx, [rbx]	
	syscall
	ret
_end_of_code:
