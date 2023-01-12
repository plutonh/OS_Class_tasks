;*****************************************************************
; syscall.asm
;*****************************************************************
; The Wagner Operating System Success Message
; Written by David Wagner
; 
; These are the system calls
; 
;*****************************************************************


;*****************************************************************
; System Calls
;*****************************************************************


;*****************************************************************
; Clear the Screen
;-----------------------------------------------------------------
; IN: None
;*****************************************************************

syscall_clear_screen:
	mov al, 0			; Scroll entire screen
	mov bh, LIGHTGREY_COLOR		; Attribute used to write blank lines
	mov ch, 0			; Top Row
	mov cl, 0			; Left Column
	mov dh, [numScreenRowsMinusOne]	; Bottom Row
	mov dl, [numScreenColumns]	; Right Column
	call bios_scroll_up
	mov dh, 0			; Cursor Row
	mov dl, 0			; Cursor Column
	call bios_move_cursor
	ret


;*****************************************************************
; Get the next key press
;-----------------------------------------------------------------
; IN: None
; OUT: [keyPressed]
;      [keyCodePressed]
;*****************************************************************

syscall_get_keypress:
	call bios_wait_for_key
	mov byte [keyPressed], al
	mov byte [keyCodePressed], ah
	ret



