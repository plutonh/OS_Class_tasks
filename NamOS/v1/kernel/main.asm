;*****************************************************************
; main.asm
;*****************************************************************
; The Wagner Operating System Success Message
; Written by David Wagner
; 
; This is the main procedure in the kernel
; After initilizing the kernel, everything else starts here
; 
;*****************************************************************



;*****************************************************************
; Main Kernel Code
;*****************************************************************


kernel_main:
	call print_newline
	call print_string_hello
	call print_newline
	call print_string_press_any_key
	call bios_wait_for_key
	call syscall_clear_screen

	mov byte [boxTop], 0
	mov byte [boxLeft], 0
	mov byte [boxWidth], 40
	mov byte [boxHeight], 5
	call print_box
	call enter_box
	call print_welcome_message
	call print_newline
	call print_newline

kernel_loop:
	call print_string_quit_or_reboot
	call syscall_get_keypress
	call print_newline

	cmp byte [keyPressed], 'q'
	je bios_power_off   		; If the user pressed q then power off

	cmp byte [keyPressed], 'r'
	jne kernel_loop			; If the user did not press q or r then ask again

	call syscall_clear_screen	; The user pressed r so clear the screen and reboot
	jmp bios_reboot


;*****************************************************************
; End of main Code
;*****************************************************************

kernel_halt:
	jmp kernel_halt			; Loop forever

