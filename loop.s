global _start
extern printf, fflush

section .data
	outFormat db  "%d", 0x0a, 0x00

section .text
_start:
  mov rcx, 15

printV:
  xor rax, rax
	mov rdi, outFormat ; set 1st argument (Print Format)
  mov rsi, rcx       ; set 2nd argument (Print This)
  push rcx
  call printf        ; printf(outFormat, rbx)
	pop rcx
	dec rcx
  jnz printV
  
  mov rdi, 0         ; NULL = flush all streams
	call fflush        ; Flushing output allows output to be writen to a file

  mov rax, 60
  mov rdi, 0
  syscall
	
