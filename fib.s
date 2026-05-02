global _start
extern printf, scanf
default abs

section .data
	message db "Max Fibonacci number: ", 0x0a
	outFormat db  "%d", 0x0a, 0x00
	inFormat db  "%lld", 0x00

section .bss
	userInput resb 1

section .text
_start:
	call printMessage   ; print intro message
	call getInput
	call initFib        ; set initial Fib values
	call loopFib        ; calculate Fib numbers
	call Exit           ; Exit the program

printMessage:
	mov rax, 1       ; rax: syscall number 1
	mov rdi, 1       ; rdi: fd 1 for stdout
	mov rsi, message ; rsi: pointer to message
	mov rdx, 22      ; rdx: print length of 20 bytes
	syscall          ; call write syscall to the intro message
	ret

initFib:
	xor rax, rax ; initialize rax to 0
	xor rbx, rbx ; initialize rbx to 0
	inc rbx      ; increment rbx to 1
	ret

getInput:
	sub rsp, 8          ; align stack to 16-bytes
	mov rdi, inFormat   ; set 1st parameter (inFormat)
	mov rsi, userInput  ; set 2nd parameter (userInput)
	call scanf          ; scanf(inFormat, userInput)
	add rsp, 8          ; restore stack alignment
	ret

printFib:
  push rax           ; push registers to stack
  push rbx
  mov rdi, outFormat ; set 1st argument (Print Format)
  mov rsi, rbx       ; set 2nd argument (Fib Number)
  call printf        ; printf(outFormat, rbx)
  pop rbx            ; restore registers from stack
  pop rax
  ret

loopFib:
	call printFib        ; print current Fib number
	add rax, rbx         ; get the next number
	xchg rax, rbx        ; swap values
	cmp rbx, [userInput] ; do rbx - userInput
	js loopFib           ; jump if result is <0
	ret

Exit:
	mov rax, 60
	mov rdi, 0
	syscall


; message: a label for a memory locationn
; db: define byte. reserve space in memory for 1 or more bytes

; We used [userInput] instead of userInput.
; 	We wanted to compare with the final value, not with the pointer address.
