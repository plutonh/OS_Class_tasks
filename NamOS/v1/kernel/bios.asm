;*****************************************************************
; bios.asm
;*****************************************************************
; The Wagner Operating System 
; Written by David Wagner
; 
; This file contains the bios calls
;
; These calls are listed at http://www.ctyme.com/intr/int.htm
; 
;*****************************************************************



;*****************************************************************
; Reboot the device
; ------------------------------------------------------------------
; IN: None
;*****************************************************************


bios_reboot:

	; ------------------------------------------------------------------
	; Reboot
	; See http://www.ctyme.com/intr/rb-2270.htm
	; ------------------------------------------------------------------

	int 19h				; Reboot the system



;*****************************************************************
; Exit to OS
; ------------------------------------------------------------------
; IN: None
;*****************************************************************


bios_exit_os:

	; ------------------------------------------------------------------
	; Terminate Program
	; See http://www.ctyme.com/intr/rb-2471.htm
	; ------------------------------------------------------------------

	int 20h				; Exit the system


;*****************************************************************
; Power off the device
; ------------------------------------------------------------------
; IN: None
;*****************************************************************


bios_power_off:

	; ------------------------------------------------------------------
	; Power Off
	; See http://www.ctyme.com/intr/rb-1404.htm
	; ------------------------------------------------------------------

	mov ax, 5307h
	mov bx, 0001h
	mov cx, 0003h
	int 15h				; Power Off the system



;*****************************************************************
; Write a String of the indicated color
; ------------------------------------------------------------------
; IN:	AL, bit 0 = Update cursor after writing
;	AL, bit 1 = String contains alternating chars and attributes
;	BH = Page Number
;	BL = Attribute if string contains only characters
;	CX = Number of Characters in String
;	DH,DL = Row, Column at which to start writing
;	ES:BP = String to Write
;
;*****************************************************************

bios_write_color_string:
	mov ah, 0x13
	int 0x10
	ret

;*****************************************************************
; Print the character contained in Register AL 
; ------------------------------------------------------------------
; IN: AL = ASCII Code of character to print, BL = color
;*****************************************************************

	; ------------------------------------------------------------------
	; Print the character and return
	; See http://www.ctyme.com/intr/rb-0106.htm
	; ------------------------------------------------------------------

bios_print_color_char:
	mov ah, 0Eh			; Load AH with the print command
	int 10h				; Print the character in AL
	ret



;*****************************************************************
; Repeatedly print the character contained in Register AL 
; ------------------------------------------------------------------
; IN: AL = ASCII Code of character to print
;     BH = page number
;     BL = display attribute
;     CX = number of times to write character
;*****************************************************************

	; ------------------------------------------------------------------
	; Print the character and return
	; See http://www.ctyme.com/intr/rb-0106.htm
	; ------------------------------------------------------------------

bios_print_repeated_char_keep_cursor:
	mov ah, 0Ah			; Load AH with the print command
	int 10h				; Print the character in AL
	ret



;*****************************************************************
; Wait for any key to be pressed
; ------------------------------------------------------------------
; IN: None; OUT: AH = Keycode, AL = ASCII code of key pressed
;*****************************************************************

bios_wait_for_key:

	; ------------------------------------------------------------------
	; Wait for a key
	; See http://www.ctyme.com/intr/rb-1754.htm
	; and http://www.ctyme.com/intr/rb-1771.htm
	; ------------------------------------------------------------------

	mov ax, 0
	int 16h				; Wait for keystroke
	ret




;*****************************************************************
; Check if a key was pressed, but do not remove it from the buffer
; ------------------------------------------------------------------
; IN: None 
; OUT: ZF = keystroke available, AH = Keycode, AL = ASCII code 
;*****************************************************************

bios_check_for_key:

	; ------------------------------------------------------------------
	; Check for a key
	; See http://www.ctyme.com/intr/rb-1755.htm
	; ------------------------------------------------------------------

	mov ah, 1			; BIOS call to check for key
	int 16h

	ret



;*****************************************************************
; Get the keycode of the last key pressed or released
; ------------------------------------------------------------------
; IN: None 
; OUT: AL bit 7 = press or release, AL bit 6-0 = Keycode
;*****************************************************************

bios_last_key_action:
	in al, 60h
	ret


;*****************************************************************
; Get the position and size of the cursor
; ------------------------------------------------------------------
; OUT: DH, DL = row, column, CH, CL = start, end scan line
;*****************************************************************

bios_get_cursor_size:
bios_get_cursor_pos:
bios_get_cursor_pos_and_size:

	; ------------------------------------------------------------------
	; Get Cursor Position
	; See http://www.ctyme.com/intr/rb-0088.htm
	; ------------------------------------------------------------------


	mov bh, 0
	mov ah, 3
	int 10h				; BIOS interrupt to get cursor position

	ret


;*****************************************************************
; Move the cursor to a position on the screen
; ------------------------------------------------------------------
; IN: DH, DL = row, column
;*****************************************************************

bios_move_cursor:

	; ------------------------------------------------------------------
	; Move Cursor
	; See http://www.ctyme.com/intr/rb-0087.htm
	; ------------------------------------------------------------------

	mov bh, 0
	mov ah, 2
	int 10h

	ret


;*****************************************************************
; Get the Time
; ------------------------------------------------------------------
; OUT: CH = hour (BCD)
;      CL = minute (BCD)
;      DH = second (BCD)
;      DL = Daylight Savings Flag (0 = Standard, 1 = Daylight)
;*****************************************************************

bios_get_time:
	mov ah, 02h
	int 1Ah
	ret

;*****************************************************************
; Get the Date
; ------------------------------------------------------------------
; OUT: CH = century (BCD)
;      CL = year (BCD)
;      DH = month (BCD)
;      DL = day
;*****************************************************************

bios_get_date:
	mov ah, 04h
	int 1Ah
	ret


;*****************************************************************
; Scroll up the screen
; ------------------------------------------------------------------
; IN: AL = Number of lines to scroll (0 = clear entire window)
;     BH = FG and BG Color 
;     CH = Scroll Area Top Row
;     CL = Scroll Area Left Column
;     DH = Scroll Area Bottom Row
;     DL = Scroll Area Right Column
;*****************************************************************

bios_scroll_up:

	; ------------------------------------------------------------------
	; Scroll Up
	; See http://www.ctyme.com/intr/rb-0096.htm
	; See https://en.wikipedia.org/wiki/BIOS_color_attributes
	; ------------------------------------------------------------------

	mov ah, 6			; Scroll up Window

	int 10h

	ret


;*****************************************************************
; Scroll down the screen
; ------------------------------------------------------------------
; IN: AL = Number of lines to scroll (0 = clear entire window)
;     BH = FG and BG Color 
;     CH = Scroll Area Top Row
;     CL = Scroll Area Left Column
;     DH = Scroll Area Bottom Row
;     DL = Scroll Area Right Column
;*****************************************************************

bios_scroll_down:

	; ------------------------------------------------------------------
	; Scroll Down
	; See http://www.ctyme.com/intr/rb-0096.htm
	; See https://en.wikipedia.org/wiki/BIOS_color_attributes
	; ------------------------------------------------------------------

	mov ah, 7			; Scroll down Window

	int 10h

	ret


;*****************************************************************
; Get the current video mode, cursor max column, and page number
; ------------------------------------------------------------------
; IN: None
; OUT: AH = number of characters in each column
;      AL = current video mode
;      BH = current active page number
;*****************************************************************

bios_get_video_mode_column_count_and_page_number:
bios_get_video_mode:
bios_get_cursor_max_column:
bios_get_page_number:
	mov ah, 0x0F
	int 0x10	; bh = Page Number, al = video mode
	ret


;*****************************************************************
; Get the Video Functionality Info and Screen Resolution
; ------------------------------------------------------------------
; IN:  ES:DI = Video Functionality Table
; OUT: AL = 1Bh if function supported
;      ES:DI = Video Functionality Table
;*****************************************************************

bios_get_video_functionality_info:
bios_get_cursor_max_row:
bios_get_cursor_max_column_word:
bios_get_cursor_resolution:
	mov ah, 0x1B
	mov bx, 0	; 0000h return funtionality/state information
;	mov di, video_functionality_info ; table address
	int 0x10	; bx = horizontal, cx = vertical
	ret


;*****************************************************************
; Set the current video mode
; ------------------------------------------------------------------
; IN:  AL = new video mode
;*****************************************************************

bios_set_video_mode:
	mov ah, 0x00
	int 0x10
	ret


;;*****************************************************************
;; Draw a white pixel in a 65000x65000 coordinate system on the screen
;; ------------------------------------------------------------------
;; IN: DX, CX = row, column
;;*****************************************************************
;
;bios_draw_white_pixel:
;
;	mov bl, WHITE_COLOR ; color = white
;	call bios_draw_pixel_current_page
;	ret
;
;
;;*****************************************************************
;; Draw a pixel in a 65000 x 65000 coordinate on the current page
;; ------------------------------------------------------------------
;; IN: DX, CX = row, column, BL = Color
;;*****************************************************************
;
;bios_draw_pixel_current_page:
;	; bh = active page number (ah = col count, al = video mode)
;	call bios_get_page_number
;;	add bh, 24
;	call bios_draw_pixel_anypage
;	ret

;*****************************************************************
; Draw a pixel at a position on the indicated page
; ------------------------------------------------------------------
; IN: DX, CX = row, column, BH = Page Number, BL = Color
;*****************************************************************

bios_draw_color_pixel_anypage:

	; draw pixel at cx = column, dx = row
	mov ah, 0x0C
	mov al, bl ; color = bl

	int 0x10

	ret



;;*****************************************************************
;; Get VESA SuperVGA Graphics information
;; ------------------------------------------------------------------
;; IN: None
;;*****************************************************************
;
;bios_get_supervga_info:
;	mov ax, 0x4f00
;	mov di, vesa_supervga_info
;	int 10h
;
;	ret
;
;;*****************************************************************
;; Get VESA SuperVGA Graphics mode information
;; ------------------------------------------------------------------
;; IN: CX = video mode
;;*****************************************************************
;
;bios_get_supervga_mode_info:
;	mov ax, 0x4f01
;	mov di, vesa_supervga_mode_info
;	int 10h
;
;	ret




