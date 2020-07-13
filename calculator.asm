.MODEL SMALL 
.STACK
.DATA
MSG      DB 'Welcome to Calculator v1.1',0DH,0AH
         DB 'Press a to add, s to subtract, m to multiply and  d to divide',0DH,0AH,0DH,0AH,'$' 
OPERATION DB    'Operation: $'
ENTER1    DB    'Enter first number: $' 
ENTER2    DB    'Enter second number: $'
SUM       DB    'The summation is: $'
DIFF      DB    'The difference is: $' 
MULT      DB    'The multiplication is: $' 
DIVIDE    DB    'The division is: $' 
A         DB    ?
B         DB    ?
ENTER     DB    0DH,0AH,'$'
COUNT     DW 0
FLAG      DW 0 
COUNT1    DW 0
COUNT2    DW 0  
NUM1      DW 0
NUM2      DW 0

.CODE
MAIN PROC 
    
    MOV AX,@DATA
    MOV DS,AX
    LEA DX,MSG
    MOV AH,9
    INT 21H   
    
    
;prompt for operation

@PROMPT:  
    MOV     AH,9
    LEA     DX,OPERATION
    INT     21H
    
    MOV     AH,1
    INT     21H
    MOV     A,AL
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
    
    MOV     AL,A
    CMP     AL,'a'
    JE      @ADDITION
    CMP     AL,'s'
    JE      @SUBTRACTION
    CMP     AL,'m'
    JE      @MULTIPLICATION
    CMP 	AL,'d'
	JE 		@DIVISION
    

@ADDITION:        
    
    MOV     AH,9
    LEA     DX,ENTER1       
    INT     21H    
    
;input a number  
    CALL    INDEC
    MOV     NUM1,AX
    PUSH    BX
    
    MOV     BX,COUNT
    MOV     COUNT1,BX 

    POP     BX
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
         
    MOV     AH,9
    LEA     DX,ENTER2  
    INT     21H

;input 2ND number    
    CALL    INDEC
    MOV     NUM2,AX 
    
    PUSH    BX
    
    MOV     BX,COUNT
    MOV     COUNT2,BX
     
    
    POP     BX
    
;reform input number

    CALL    REFORMNUM
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
    MOV     AX,NUM2
    ADD     AX,NUM1  
    PUSH    AX
    
    MOV     AH,9
    LEA     DX,SUM       
    INT     21H 
    
    JMP     @PRINT:        
    
@SUBTRACTION: 

    MOV     AH,9
    LEA     DX,ENTER1       
    INT     21H    
    
;input a number  
    CALL    INDEC
    MOV     NUM1,AX
    PUSH    BX
    
    MOV     BX,COUNT
    MOV     COUNT1,BX 
    POP     BX
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
         
    MOV     AH,9
    LEA     DX,ENTER2  
    INT     21H

;input 2ND number    
    CALL    INDEC
    MOV     NUM2,AX 
    
    PUSH    BX
    
    MOV     BX,COUNT
    MOV     COUNT2,BX 
    
    POP     BX
    
;reform input number

    CALL    REFORMNUM
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
    MOV     AX,NUM2
    SUB     AX,NUM1
    NEG     AX  
    PUSH    AX
    
    MOV     AH,9
    LEA     DX,DIFF       
    INT     21H 
    
    JMP     @PRINT: 

@MULTIPLICATION:

    MOV     AH,9
    LEA     DX,ENTER1       
    INT     21H    
    
;input a number  
    CALL    INDEC
    MOV     NUM1,AX
    PUSH    BX
    
    MOV     BX,COUNT
    MOV     COUNT1,BX 
  
    
    POP     BX
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
         
    MOV     AH,9
    LEA     DX,ENTER2  
    INT     21H

;input 2ND number    
    CALL    INDEC
    MOV     NUM2,AX 
    
    PUSH    BX
    
    MOV     BX,COUNT1
    ADD     COUNT,BX
    
    
    POP     BX 
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
    MOV     AX,NUM1
    IMUL    NUM2
    CWD
    
    PUSH    AX
    PUSH    DX
    
    MOV     AH,9
    LEA     DX,MULT       
    INT     21H 
    
    POP     AX
    POP     AX
    CALL    OUTDEC
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    JMP     @PROMPT   

@DIVISION:
	MOV     AH,9
    LEA     DX,ENTER1       
    INT     21H    
    
;input a number  
    CALL    INDEC
    MOV     NUM1,AX
    PUSH    BX
    
    MOV     BX,COUNT
    MOV     COUNT1,BX 
    
    POP     BX
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
         
    MOV     AH,9
    LEA     DX,ENTER2  
    INT     21H

;input 2ND number    
    CALL    INDEC
    MOV     NUM2,AX 
    
    PUSH    BX
    
    MOV     BX,COUNT
    ADD     BX,COUNT1
    MOV     COUNT,BX 
    
    POP     BX 
    
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    
    MOV     AX,NUM1
	CWD
    IDIV    NUM2
    
    PUSH    DX
    PUSH    AX
    
    MOV     AH,9
    LEA     DX,DIVIDE      
    INT     21H 
    
	
    POP     AX
	CALL 	OUTDEC
	
	POP 	DX
	CMP 	DX,0
	JE 		@END2
	
	PUSH 	DX
	
	MOV 	AH,2
	MOV 	DL,'/'
	INT 	21H
	
    POP     AX
    CALL    OUTDEC
	
	MOV 	AH,2
	MOV 	DL,'/'
	INT 	21H
	
	MOV 	AX,NUM2
	CALL	OUTDEC
 @END2:   
    MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
    JMP     @PROMPT  
@PRINT:
		
; output the number
    POP     AX
	CALL 	OUTDEC 
	
	MOV     AH,2
    MOV     DL,0DH
    INT     21H
    MOV     DL,0AH
    INT     21H
	JMP     @PROMPT
; dos exit
	MOV 	AH,4CH
	INT		21H

MAIN ENDP

INCLUDE display.asm
INCLUDE input_dec.asm


REFORMNUM PROC

	PUSH	AX		; save registers
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH 	COUNT1
	PUSH 	COUNT2
	
	
	MOV 	CX,COUNT1
	CMP 	CX,COUNT2
	JG		@SEC
	JL 		@FIRST
	JMP 	@EXIT1
	
 @SEC:
	MOV 	COUNT,CX
	SUB 	CX,COUNT2 
	MOV     AX,NUM2
	MOV 	NUM2,10
	
	 @TOP1:	
		IMUL 	NUM2 	
		LOOP 	@TOP1
	
	MOV 	NUM2,AX
	JMP 	@EXIT1
	
 @FIRST:
	
	MOV 	AX,COUNT2
	MOV 	COUNT,AX
	SUB 	CX,COUNT2
	NEG 	CX
	MOV 	AX,NUM1
	MOV     NUM1,10
	
	 @TOP2:	
		IMUL 	NUM1 		
		LOOP 	@TOP2
	
	MOV 	NUM1,AX
	
@EXIT1:
	
	POP 	COUNT2
	POP 	COUNT1
	POP 	DX
	POP 	CX
	POP 	BX
	POP 	AX
RET
REFORMNUM ENDP
	
	
END MAIN    
