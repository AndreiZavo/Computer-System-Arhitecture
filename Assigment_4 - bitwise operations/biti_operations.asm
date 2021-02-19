bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 01010101
    b dw 00101101
    c dw 10111010
    d dw 01001101
; our code starts here
segment code use32 class=code
    start:
		;Given 4 bytes, compute in AX the sum of the integers represented by the bits 4-6 of the 4 bytes.
		
        mov BL, [a] 		;BL := 01010101b
        and BL, 01110000b 	;BL := 01010000b
        mov CL, 4			;CL := 4
        ror BL, CL 			;BL := 00000101b
        mov AL, [b] 		;AL := 00101101b
        and AL, 0111000b 	;AL := 00100000b
        ror AL, CL 			;AL := 00000100b
        add AL, BL 			;AL := 00000001b
        mov BL, 0			;BL := 0
        mov BL, [c] 		;BL := 10111010b
        and BL, 01110000b 	;BL := 01110000b
        ror BL, CL  		;BL := 00000111b
        add AL, BL  		;AL := 00000110b
        mov BL, 0			;BL := 0
        mov BL, [d]			;BL := 01001101b
        and BL, 01110000b	;BL := 01000000b
        ror BL, CL			;BL := 00000100b
        add AL, BL			;AL := 00000111b
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
