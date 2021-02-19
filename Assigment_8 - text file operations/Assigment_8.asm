bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    msg_a db "a= ", 0
    msg_b db "b= ", 0
    format db'%d', 0
    print_format_equal db "<a> = <b>", 0
    print_format_gratter db "<a> > <b>", 0
    print_format_smaller db "<a> < <b>", 0
    
; our code starts here
segment code use32 class=code
    start:
        push dword msg_a
        call[printf]
        add esp, 4 * 1
        
        push dword a
        push dword format
        call[scanf]
        add esp, 4 * 1
        
        push dword msg_b
        call[printf]
        add esp, 4 * 1
        
        push dword b
        push dword format
        call[scanf]
        add esp, 4 * 2
        
        mov EAX, [a]
        mov EDX, [b]
        cmp EAX, EDX
        jne not_equal
            push dword [b]
            push dword [a]
            push print_format_equal
            call [printf]
            add esp, 4 * 3
            
         not_equal:
            jnl greater
                push dword [b]
                push dword [a]
                push print_format_smaller
                call[printf]
                add esp, 4 * 3
            greater:
                jng bye
                    push dword [b]
                    push dword [a]
                    push print_format_gratter
                    call[printf]
                    add esp, 4 * 3
               bye:
               ;nothing
        
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
