section .text
global square_of_sum
square_of_sum:
    mov rax, rdi       ; tmp val n
    inc rax            ; n + 1
    imul rax, rdi      ; (n + 1)n
    shr rax, 1         ; (n + 1)n/2
    imul rax, rax      ; (n + 1)n/2 ** 2
    ret

global sum_of_squares
sum_of_squares:
    mov rax, rdi       ; tmp val n
    inc rax            ; n + 1
    imul rax, rdi      ; (n + 1)n
    imul rdi, 2        ; t = 2n
    inc rdi            ; t = 2n + 1
    xor rdx, rdx       ; clear out high bits 
    imul rax, rdi      ; (2n + 1)(n + 1)n
    mov rdi, 6         ; divisor = 6
    div rdi            ; (2n + 1)(n + 1)n/divisor
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
