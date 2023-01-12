;*****************************************************************
; ascii.asm
;*****************************************************************
; The Wagner Operating System 
; Written by David Wagner
; 
; This file contains the ascii print calls
;
;*****************************************************************

;*****************************************************************
;  Special Characters
;*****************************************************************

%DEFINE VERTICALBAR_CHAR 0xB3
%DEFINE HORIZONTALBAR_CHAR 0xC4
%DEFINE TOPRIGHTCORNER_CHAR 0xBF
%DEFINE TOPLEFTCORNER_CHAR 0xDA
%DEFINE BOTTOMRIGHTCORNER_CHAR 0xD9
%DEFINE BOTTOMLEFTCORNER_CHAR 0xC0

%DEFINE DOUBLE_VERTICALBAR_CHAR 0xBA
%DEFINE DOUBLE_HORIZONTALBAR_CHAR 0xCD
%DEFINE DOUBLE_TOPRIGHTCORNER_CHAR 0xBB
%DEFINE DOUBLE_TOPLEFTCORNER_CHAR 0xC9
%DEFINE DOUBLE_BOTTOMRIGHTCORNER_CHAR 0xBC
%DEFINE DOUBLE_BOTTOMLEFTCORNER_CHAR 0xC8

%DEFINE DOUBLETOP_SINGLERIGHTCORNER_CHAR 0xB8
%DEFINE DOUBLETOP_SINGLELEFTCORNER_CHAR 0xD5
%DEFINE DOUBLEBOTTOM_SINGLERIGHTCORNER_CHAR 0xBE
%DEFINE DOUBLEBOTTOM_SINGLELEFTCORNER_CHAR 0xD4

%DEFINE SPACE_CHAR 0x20
%DEFINE COMMA_CHAR 0x2c
%DEFINE SMALLX_CHAR 0x78
%DEFINE SLASH_CHAR 0x2f
%DEFINE DASH_CHAR 0x2d
%DEFINE COLON_CHAR 0x3a

%DEFINE CARRIAGERETURN_CHAR 0x0d
%DEFINE LINEFEED_CHAR 0x0a

%DEFINE BACKSPACE_CHAR 0x08

%DEFINE UPDOWNARROW_CHAR 0x12
%DEFINE UPARROW_CHAR 0x18
%DEFINE DOWNARROW_CHAR 0x19
%DEFINE LEFTRIGHTARROW_CHAR 0x1D
%DEFINE LEFTARROW_CHAR 0x1B
%DEFINE RIGHTARROW_CHAR 0x1A





;*****************************************************************
; Print a carriage return character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_carriage_return:
	mov al, CARRIAGERETURN_CHAR ;13	; Copy Carriage Return to AL
	call bios_print_color_char
	ret

;*****************************************************************
; Print a line feed character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_line_feed:
	mov al, LINEFEED_CHAR ;10	; Copy Line Feed to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a space character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_space:
	mov al, SPACE_CHAR		; Copy space character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a backspace character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_backspace:
	mov al, BACKSPACE_CHAR		; Copy space character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a comma character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_comma:
	mov al, COMMA_CHAR		; Copy comma character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a small 'x' character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_smallx:
	mov al, SMALLX_CHAR		; Copy comma character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a slash character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_slash:
	mov al, SLASH_CHAR		; Copy slash character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a dash character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_dash:
	mov al, DASH_CHAR		; Copy dash character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a colon character
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_colon:
	mov al, COLON_CHAR		; Copy colon character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a vertical bar
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_vertical_bar:
	mov al, VERTICALBAR_CHAR	; Copy vertical bar character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a double vertical bar
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_double_vertical_bar:
	mov al, DOUBLE_VERTICALBAR_CHAR	; Copy vertical bar character to AL
	call bios_print_color_char
	ret

;*****************************************************************
; Print a horizontal bar
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_horizontal_bar:
	mov al, HORIZONTALBAR_CHAR	; Copy horizontal bar character to AL
	call bios_print_color_char
	ret


;*****************************************************************
; Print a double horizontal bar
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_double_horizontal_bar:
	mov al, DOUBLE_HORIZONTALBAR_CHAR ; Copy horizontal bar character to AL
	call bios_print_color_char
	ret

;*****************************************************************
; Print a top right corner
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_top_right_corner:
	mov al, TOPRIGHTCORNER_CHAR
	call bios_print_color_char
	ret

;*****************************************************************
; Print a top left corner
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_top_left_corner:
	mov al, TOPLEFTCORNER_CHAR
	call bios_print_color_char
	ret

;*****************************************************************
; Print a bottom right corner
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_bottom_right_corner:
	mov al, BOTTOMRIGHTCORNER_CHAR
	call bios_print_color_char
	ret

;*****************************************************************
; Print a bottom left corner
; ------------------------------------------------------------------
; IN: None
;*****************************************************************

print_ascii_bottom_left_corner:
	mov al, BOTTOMLEFTCORNER_CHAR
	call bios_print_color_char
	ret




