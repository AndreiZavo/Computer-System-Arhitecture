bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
global perm
; declare external functions needed by our program
extern exit , printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
      b dd 0
      form dd "%x" , 0
      new_line dd 10,0
    

; our code starts here
segment code use32 class=code
    perm:
        mov ecx , [esp+4]
            
        mov [b] , ecx 
            push dword new_line
            call [printf]
            add esp , 4
        mov ecx , 8
        
        repeta:
            mov eax , [b]
            ror eax , 4
            mov [b] , eax 
            pushad 
            push dword [b]
            push dword form
            call [printf]
            add esp , 4*2
            push dword new_line
            call [printf]
            add esp , 4
            popad
        loop repeta
    ret