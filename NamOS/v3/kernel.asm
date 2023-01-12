; ==================================================================
; kernel.asm
; ==================================================================
; The Wagner Operating System Kernel
; Written by David Wagner
;
; ==================================================================


; ==================================================================
; Parts of Kernel
; ==================================================================

	%INCLUDE "kernel/constants.asm"
	%INCLUDE "kernel/initkern.asm"
	%INCLUDE "kernel/ascii.asm"
	%INCLUDE "kernel/main.asm"
	%INCLUDE "kernel/bios.asm"
	%INCLUDE "kernel/syscalls.asm"
	%INCLUDE "kernel/strings.asm"
	%INCLUDE "kernel/print.asm"
	%INCLUDE "kernel/memory.asm"


; ==================================================================
; END OF KERNEL
; ==================================================================
