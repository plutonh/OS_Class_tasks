;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ========================================================================
;; myname_memwrite.asm 		           Written by Nam Jonghyeon
;; ========================================================================
;;
;; Print "Hello" by directly writing video memory
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
	mov byte [ypos], 8 ; Start in the 8th Row
	mov byte [xpos], 0 ; Start in the 0th Column
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
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_a
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_m
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_SPACE
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_J
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_o
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_n
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_g
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_h
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_y
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_e
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_o
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov bl, GREEN
	mov al, CHAR_n
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	mov al, CHAR_SPACE
	call memwrite_print_char
	add byte [ypos], 1 ; increment video memory
	ret

; =========================================================================
; 			   MEMORY WRITE PRINT CHAR
; =========================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Print a single character. Do not use a BIOS Call
;; Instead copy the character directly to video memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INPUT:
;;         al = character to print
;;         bl = color
;; LOCAL:
;;         cx = character and color
;;         ax = row offset in video memory
;;         bx = column offset in video memory
;;         di = total offset in video memory
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
memwrite_print_char:
	mov ah, bl
	mov cx, ax    ; Store character ad color in cx
	movzx ax, byte [ypos] ; Store row number in ax
	mov dx, 160
	mul dx        ; ax = ypos * 160 (row offset)
	movzx bx, byte [xpos] ; Store column number in bx
	shl bx, 1     ; bx = xpos * 2 (column offset)
	mov di, 0
	add di, ax
	add di, bx    ; di = (ypos * 160) + (xpos * 2)
	
	mov ax, cx
	stosw ; Copy from register ax to video memory [es:di]
	
	ret
	
; =========================================================================
; 		       Variables in Main Memory
; =========================================================================

xpos db 0
ypos db 0

; =========================================================================
; 		      Fill Boot Sector to 512 Bytes
; =========================================================================

times 510-($-$$) db 0
dw 0AA55h
