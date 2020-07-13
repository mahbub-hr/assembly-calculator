       
OUTDEC PROC
;prints AX as a signed decimal integer
;input: AX
;output: none
	PUSH	AX		; save registers
	PUSH	BX
	PUSH	CX
	PUSH	DX
;if AX < o·
	OR		AX, AX	;AX < 0?
	JGE		@END_IF	; NO, > 0 
 ;then
	PUSH	AX		; save number
	MOV		DL,'-'	;get • -•
	MOV 	AH,2	;print char !unction
	INT		21H		;print '-•
	POP		AX		;get AX back
	NEG		AX		;AX = -AX.

@END_IF:
 ;get decimal digits
	XOR 	CX,CX	;CX counts digits
	MOV 	BX, 10D	;BX has divisor
 @REPEAT:
	XOR		DX,DX	;prepare high word of dividend
	DIV		BX		;AX = quotient, DX = remainder
	PUSH	DX		;save remainder on stack
	INC		CX		; count = count + 1
    CMP 	CX,COUNT
	JG 		@N_EQUAL
	JL 		@N_EQUAL
	MOV 	DX,'.'
	PUSH 	DX
	INC 	CX
 @N_EQUAL:
 ;until·
	OR AX,AX 		;quotient = 0?
	JNE @REPEAT 	; no, keep going
	
 ;convert digits to characters and print
	MOV AH,2 		;print char function

 ;for count times do
 @PRINT_LOOP:
	POP		DX			;digit in DL
	CMP 	DL,'.'
	JE 		@FLOW
	OR		DL,30H      ;convert to character
	
	@FLOW:
    INT		21H         ;print digit
    LOOP	@PRINT_LOOP ; loop until done
 ;end_for
 
 ;restore registrs
    POP		DX
    POP 	CX
	POP 	BX
	POP 	AX
	
 RET
 OUTDEC ENDP
