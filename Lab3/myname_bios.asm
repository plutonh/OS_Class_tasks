;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ========================================================================
;; myname_bios.asm 				   Written by Nam Jonghyeon
;; ========================================================================
;;
;; Print "Hello" using BIOS calls
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; =========================================================================
; 				Constants
; =========================================================================

%include "colors.asm"
%include "ascii_codes.asm"

; =========================================================================
; 			   START OF INSTRUCTIONS
; =========================================================================

%include "init_segment_registers.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Main Procedure
;;	Print Hello then Loop infinitely
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:
	call print_hello
end_loop:
	jmp end_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Print Hello
;;  LOCAL:
;;     al = current character to print
;;     bl = color
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_hello:
	mov bl, GREEN
	mov al, CHAR_N
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_a
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_m
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_SPACE
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_J
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_o
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_n
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_g
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_h
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_y
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_e
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_o
	call bios_print_char
	mov bl, GREEN
	mov al, CHAR_n
	call bios_print_char
	mov al, CHAR_SPACE
	call bios_print_char
	ret
	
; =========================================================================
; 			   BIOS PRINT CHAR
; =========================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Print a single character with a BIOS call
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INPUT:
;;         al = character to print
;;         bl = color
;; LOCAL:
;;         ah = 0x0E (interrupt code for printing)
;;
;; See https://www.ctyme.com/intr/rb-0106.htm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bios_print_char:
	mov ah, 0x0E
	int 0x10
	ret
	
; =========================================================================
; 		      Fill Boot Sector to 512 Bytes
; =========================================================================

times 510-($-$$) db 0
dw 0AA55h
