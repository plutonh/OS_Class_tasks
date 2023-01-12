;helloLinux.asm

section .data

msg:
	DB 'Hello Linux', 10
	msgSize EQU $-msg
	global start
	
section .text

start:
	mov rax, 4
	mov rbx, 1
	mov rcx, msg
	mov rdx, msgSize
	int 0x80
	
	mov rax, 1
	mov rbx, 0
	int 0x80
	ret
