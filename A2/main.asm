;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:

register:
				  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9

	  	  					;Register Addressing mode

      mov.w PC,R4 			; move word from PC to R4
	  mov.w R4,R5 			; move word from P4 to R5
	  mov.w R5,R6 			; move word from P5 to R6

Imm:			  			;immidiate Addressing mode

	  			  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9

	  mov.w #5678h,R4 		; move hex value 5678 to R4
	  mov.w #0FA20h,R5 		; move hex value FA20 to R5 Note:Needs a 0 before a letter
	  mov.b #01h,R6 		; move hex value 01to R6
	  mov.b #10,R7 			; move decimal value 10 to R7
	  mov.b #10101010b,R8 	; move bonary value 10101010 to R8
	  mov.b #'A',R9		    ; move ASCII value of 'A' to R9

abs:						;Absolute Addressing mode

	  			  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9

	  mov.w &2000h,R4 		; move the content of address 2000h to R4
	  mov.w R4,&2004h 		; move the content of R4 to address 2004h
	  mov.w &2002h,R5 		; move the content of address 2002h to R5
	  mov.w R5,&2006h 		; move the content of R5 to address 2006h

Sym:						;symbolic Addressing mode

	  			  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9
	  CLR.w var1
	  CLR.w var2

	  mov.w constant1,R4 	; move the content of address 2000h to R4
	  mov.w constant2,R5 	; move the content of address 2000h to R5
	  mov.w var1,R6 		; move the content of address 2000h to R6
	  mov.w var2,R7 		; move the content of address 2000h to R7

indirect:					;indirect Addressing mode

	  			  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9
	  CLR.w var1
	  CLR.w var2

	  mov.w #2000h,R4 		; move hex value 2000h to R4 [immidiate addressing]
	  mov.w @R4,R5 			; move the content of address 2000h(in R4) to R5
	  mov.w #constant2,R6 	; move numerical value of constant2's address to R6
	  mov.w @R6,R7 			; move the content of address 2002h to R7

auto:						;Autoincrement Addressing mode

	  			  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9
	  CLR.w var1
	  CLR.w var2

	  mov.w #block1,R4 		; move numerical value of iniatial block1 address to R4 [immidiate addressing]
	  mov.w @R4+,R5 		; move the content of address in R4 to R5
	  mov.w @R4+,R6 		; move the content of address in R4 to R6
	  mov.w @R4+,R7 		; move the content of address in R4 to R7
	  mov.w @R4+,R8 		; move the content of address in R4 to R8
	  mov.w @R4+,R9 		; move the content of address in R4 to R9


index:						;Index Addressing mode

	  			  			; clear registers
	  CLR.w R4
	  CLR.w R5
	  CLR.w R6
	  CLR.w R7
	  CLR.w R8
	  CLR.w R9
	  CLR.w var1
	  CLR.w var2

	  mov.w #constant1,R4 	; move numerical value of iniatial constant1 address to R4 [immidiate addressing]
	  mov.w 8(R4),18(R4)	; move the content of address in R4 to 4 bytes ahead
	  mov.w 10(R4),20(R4)	; move the content of address in R4 to 4 bytes ahead
	  mov.w 12(R4),22(R4)	; move the content of address in R4 to 4 bytes ahead
	  mov.w 14(R4),24(R4)	; move the content of address in R4 to 4 bytes ahead
	  mov.w 16(R4),26(R4)	; move the content of address in R4 to 4 bytes ahead



      jmp	init
      nop
;-------------------------------------------------------------------------------
;Memory allocation
;------------------------------------------------------------------------------
			.data 			;go to Data memory address 2000hex
   			.retain     	;keep this section even if not used

constant1: .short  5678h	;define a constant in address 2000h with 5678h inside
constant2: .short  0CAFEh	;define a constant in address 2002h with CAFEh inside

var1:		.space 2		;reserve space in next address for var1
var2:		.space 2		;reserve space in next address for var1

block1:	   .short  1122h,	3344h,	5566h,	7788h,	99AAh    ;A block of addresses starting from 2008
block2:	   .space 8			;A block of 8 spaces [4 bytes]

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
