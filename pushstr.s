global _start

section .text
_start:
	xor rbx, rbx
	mov ebx, 'ings'
	push rbx
	mov rbx, 'tial Str'
	push rbx
	mov rbx, 'Push Par'
	push rbx
	mov rsi, rsp
	mov al, 1
	xor rdi, rdi
	mov dil, 1
	xor rdx, rdx
	mov dl, 20    ; Number of printed chars
	syscall

	xor rax, rax
	add al, 60
	xor dil, dil
	syscall

