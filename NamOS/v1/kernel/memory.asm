;*****************************************************************
; memory.asm
;*****************************************************************
; The Wagner Operating System 
; Written by David Wagner
; 
; This file allocates memory for system variables and memory buffers
; 
; db = byte size data
; dw = word size data
; dd = double word size data
;
;*****************************************************************


;*****************************************************************
;  Data to be printed
;*****************************************************************

	charToPrint		db 0
	stringToPrint		dw 0
	byteToPrint		db 0
	wordToPrint		dw 0
	variableToPrint		dw 0


;*****************************************************************
;  String or character data
;*****************************************************************

	stringLength		dw 0
	repeatCount		dw 1
	keyPressed		db 0
	keyCodePressed		db 0

;*****************************************************************
;  Screen data
;*****************************************************************

	numScreenColumns	db 80
	numScreenRowsMinusOne	db 23

;*****************************************************************
;  Box data
;*****************************************************************

	boxTop			db 0
	boxLeft			db 0
	boxHeight		db 2
	boxWidth		db 2
	cursorInBox		db 0



