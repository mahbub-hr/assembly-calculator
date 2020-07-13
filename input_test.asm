.MODEL SMALL 
.STACK
.CODE
MAIN PROC
;input a number
	CALL	INDEC		;number in AX
	PUSH	AX			;save number
	
	MOV		AH,2		;move cursor to a new line
	MOV		DL,0DH
	INT		21H
	MOV		DL,0AH
	INT		21H
	
; output the number
	POP 	AX
	CALL 	OUTDEC
; dos exit
	MOV 	AH,4CH
	INT		21H

MAIN ENDP

INCLUDE display.asm
INCLUDE input_dec.asm

END MAIN