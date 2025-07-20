section .text
global leap_year
leap_year:
    test edi, 3         ; check if lower 2 bits are zero (meaning divisible by 4)
    je .div_by_100      ; return true
    jmp .ret_false

.ret_true:
    mov eax, 1
    ret
.ret_false:
    mov eax, 0
    ret

.div_by_100:
    mov eax, edi
    mov ecx, 100
    xor edx, edx
    div ecx
    cmp edx, 0
    je .div_by_400
    jmp .ret_true

.div_by_400:
    mov eax, edi
    mov ecx, 400
    xor edx, edx
    div ecx
    cmp edx, 0
    je .ret_true
    jmp .ret_false
    

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
