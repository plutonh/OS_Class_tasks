; ==================================================================
; strings.asm
; ==================================================================
; The Nam Operating System 
; Written by Nam Jonghyeon
;
; Strings
; ==================================================================


;*****************************************************************
; Strings
;*****************************************************************

	hello_str db			"Hello!", 0
	press_any_key_str db 		"Press a key.....", 0
	welcome_line1_str db		"Welcome to the Nam OS", 0
	welcome_line2_str db		"Written by Nam Jonghyeon", 0
	;quit_or_reboot_str db		"Q)uit or R)eboot", 0
	question_city_str db		" What is the biggest city in Korea?", 0
	num_1_city_str db		"S)eoul", 0
	num_2_city_str db		"B)usan", 0
	num_3_city_str db		"D)aegu", 0
	num_4_city_str db		"G)wanju", 0
	correct_message_str db		"That's correct", 0
	try_again_str db		"Try again!", 0

;*****************************************************************
; Procedure to get the length of a string
; ------------------------------------------------------------------
; IN:  [stringToPrint]
; OUT: [stringLength] (stringLength is also stored in cx)
;*****************************************************************

get_string_length:
	mov si, [stringToPrint]
	mov cx, 0
test_char_in_get_string_length:
	lodsb
	inc cx
	cmp al,0
	jne test_char_in_get_string_length

	dec cx
	mov [stringLength], cx
	ret

;*****************************************************************
; Procedures to print strings
;*****************************************************************

print_string_hello:
	mov word [stringToPrint], hello_str
	call print_string
	ret

print_string_press_any_key:
	mov word [stringToPrint], press_any_key_str
	call print_string
	ret

print_string_welcome_line1:
	mov word [stringToPrint], welcome_line1_str
	call print_string
	ret

print_string_welcome_line2:
	mov word [stringToPrint], welcome_line2_str
	call print_string
	ret

;print_string_quit_or_reboot:
;	mov word [stringToPrint], quit_or_reboot_str
;	call print_string
;	ret

print_string_question_city:
	mov word [stringToPrint], question_city_str
	call print_string
	ret
	
print_string_num_1_city:
	mov word [stringToPrint], num_1_city_str
	call print_string
	ret
	
print_string_num_2_city:
	mov word [stringToPrint], num_2_city_str
	call print_string
	ret
	
print_string_num_3_city:
	mov word [stringToPrint], num_3_city_str
	call print_string
	ret
	
print_string_num_4_city:
	mov word [stringToPrint], num_4_city_str
	call print_string
	ret

print_correct_message:
	mov word [stringToPrint], correct_message_str
	call print_string
	ret

print_try_again_message:
	mov word [stringToPrint], try_again_str
	call print_string
	ret

