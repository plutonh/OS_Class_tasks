; ==================================================================
; print.asm
; ==================================================================
; The Wagner Operating System 
; Written by David Wagner
;
; Procedures to print something
; ==================================================================


;*****************************************************************
; Move the cursor to the beginning of the next line.
;*****************************************************************

print_newline:
	mov bl, WHITE_COLOR
	call print_ascii_line_feed
	call print_ascii_carriage_return
	ret

;*****************************************************************
; Print a character
; ------------------------------------------------------------------
; IN:  [charToPrint]
;*****************************************************************

print_char:
	mov bl, WHITE_COLOR
	mov al, [charToPrint]
	call bios_print_color_char
	ret

;*****************************************************************
; Print a string
; ------------------------------------------------------------------
; IN:  [stringToPrint]
;*****************************************************************

print_string:
	mov si, [stringToPrint]
print_char_in_string_loop:
	lodsb        ; copy [si]->al and increment si
	cmp al,0
	je print_ret

	mov bl, WHITE_COLOR
	call bios_print_color_char
	jmp print_char_in_string_loop

print_ret:
	ret

;*****************************************************************
; Print a character repeatedly on a horizontal line
; ------------------------------------------------------------------
; IN:  [charToPrint]
;      [repeatCount]
;*****************************************************************

print_repeated_horizontal_char:
	mov bl, WHITE_COLOR
	mov al, [charToPrint]
	mov cl, [repeatCount]
	call bios_print_repeated_char_keep_cursor
	ret

;*****************************************************************
; Print a character repeatedly on a vertical line
; ------------------------------------------------------------------
; IN:  [charToPrint]
;      [repeatCount]
;*****************************************************************

print_repeated_vertical_char:
	cmp byte [repeatCount], 0
	jle print_ret

	mov al, [charToPrint]
	call print_char
	call print_ascii_line_feed
	call print_ascii_backspace
	dec byte [repeatCount]
	jmp print_repeated_vertical_char


;*****************************************************************
; Print a horizontal bar line
; ------------------------------------------------------------------
; IN:  [repeatCount]
;*****************************************************************

print_horizontal_bar:
	mov byte [charToPrint], HORIZONTALBAR_CHAR
	call print_repeated_horizontal_char
	ret


;*****************************************************************
; Print a vertical bar line
; ------------------------------------------------------------------
; IN:  [repeatCount]
;*****************************************************************

print_vertical_bar:
	mov byte [charToPrint], VERTICALBAR_CHAR
	call print_repeated_vertical_char
	ret


;*****************************************************************
; Print a box
; ------------------------------------------------------------------
; IN:  [boxTop]
;      [boxLeft]
;      [boxHeight]
;      [boxWidth]
;*****************************************************************

print_box:
	mov dh, [boxTop]
	mov dl, [boxLeft]
	call bios_move_cursor

	mov bl, WHITE_COLOR

	call print_ascii_top_left_corner

	mov cl, [boxWidth]		; Print the top edge of the box
	sub cl, 2
	mov [repeatCount], cl
	call print_horizontal_bar

	mov dh, [boxTop]
	mov dl, [boxLeft]
	add dl, [boxWidth]
	sub dl, 1
	call bios_move_cursor

	call print_ascii_top_right_corner

	call print_ascii_line_feed
	call print_ascii_backspace

	mov cl, [boxHeight]		; Print the right edge of the box
	sub cl, 2
	mov [repeatCount], cl
	call print_vertical_bar

	mov dh, [boxTop]
	mov dl, [boxLeft]
	call bios_move_cursor

	call print_ascii_line_feed

	mov cl, [boxHeight]		; Print the left edge of the box
	sub cl, 2
	mov [repeatCount], cl
	call print_vertical_bar

	call print_ascii_bottom_left_corner

	mov cl, [boxWidth]		; Print the bottom edge of the box
	sub cl, 2
	mov [repeatCount], cl
	call print_horizontal_bar

	mov dh, [boxTop]
	add dh, [boxHeight]
	sub dh, 1
	mov dl, [boxLeft]
	add dl, [boxWidth]
	sub dl, 1
	call bios_move_cursor

	call print_ascii_bottom_right_corner

	ret

;*****************************************************************
; Move the cursor to the beginning of the next line inside a box.
;*****************************************************************

enter_box:
	mov dh, [boxTop]
	inc dh
	mov dl, [boxLeft]
	inc dl
	call bios_move_cursor
	ret


;*****************************************************************
; Move the cursor to the beginning of the next line inside a box.
;*****************************************************************

print_newline_in_box:
	call bios_get_cursor_pos
	inc dh
	mov dl, [boxLeft]
	inc dl
	call bios_move_cursor
	ret


;*****************************************************************
; Print a message welcoming you to the OS
;*****************************************************************

print_welcome_message:
	call print_string_welcome_line1
	call print_newline_in_box
	call print_string_welcome_line2
	call print_newline_in_box
	ret
	
;*****************************************************************
; Print a message of city
;*****************************************************************

print_list_city:
	call print_string_num_1_city
	call print_newline_in_box
	call print_string_num_2_city
	call print_newline_in_box
	call print_string_num_3_city
	call print_newline_in_box
	call print_string_num_4_city
	call print_newline_in_box
	ret


