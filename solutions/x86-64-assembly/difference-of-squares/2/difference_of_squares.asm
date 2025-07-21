section .text
global square_of_sum
square_of_sum:
    xor eax, eax ; cleanup accumulator
.loop:
    add rax, rdi
    dec rdi
    test rdi, rdi
    jne .loop
    mul rax
    ret

global sum_of_squares
sum_of_squares:
    xor eax, eax ; cleanup accumulator
.loop:
    mov rcx, rdi
    imul rcx, rcx
    add rax, rcx
    dec rdi
    test rdi, rdi
    jne .loop
    ret

global difference_of_squares
difference_of_squares:
    mov r10, rdi
    call square_of_sum
    mov r9, rax
    mov rdi, r10
    call sum_of_squares
    sub r9, rax
    mov rax, r9
    ret
    
    

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
