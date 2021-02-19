bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf              
import exit msvcrt.dll  
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "read_from.txt", 0
    acces_mode db "r", 0
    file_descriptor dd -1
    len equ 100
    text times (len + 1) db 0
    msg_to_print db "The number of vowels is: %d  And the string is: %s", 0
    format db '%s', 0
    nr db 0 
    
    
; our code starts here
segment code use32 class=code
    start:
        push dword acces_mode
        push dword file_name
        call[fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], EAX
        cmp EAX, 0
        je final
        
        push dword [file_descriptor]
        push len
        push dword 1
        push dword text
        call[fread]
        add esp, 4 * 4
        
        mov DL, [nr]
        mov esi, text
        mov ECX, len
        cmp ECX, 0
        je final
            repeat:
                lodsb
                cmp AL, 'a'
                je vowel
                cmp AL, 'e'
                je vowel
                cmp AL, 'i'
                je vowel
                cmp AL, 'o'
                je vowel
                cmp AL, 'u'
                je vowel
                cmp AL, 'A'
                je vowel
                cmp AL, 'E'
                je vowel
                cmp AL, 'I'
                je vowel
                cmp AL, 'O'
                je vowel
                cmp AL, 'U'
                je vowel
                jmp next
                vowel:
                    add DL, 1
                next:
                loop repeat
        
        mov [nr],DL
        
        push dword text
        push dword [nr]
        push dword msg_to_print
        call [printf]
        add esp, 4 * 3
        
        push dword [file_descriptor]
        call[fclose]
        add esp, 4
       
                
       
        final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
