section .text

; using comisd cause it's better to have an error when there's a NaN

init:
    movsd xmm0, [rsp+16]
    movsd xmm1, [rsp+24]
    movsd xmm2, [rsp+32]
    ret
    
ret_true:
    mov eax, 1
    ret
    
ret_false:
    xor eax, eax
    ret
    
are_all_positive:
    pxor xmm3, xmm3
    
    comisd xmm0, xmm3
    jbe ret_false
    
    comisd xmm1, xmm3
    jbe ret_false
    
    comisd xmm2, xmm3
    jbe ret_false
    
    jmp ret_true

is_triangle_inequality_respected:
    pxor xmm3, xmm3    ; let's create a tmp = 0
    
    movsd xmm3, xmm0    ; tmp = a
    addsd xmm3, xmm1    ; tmp += b
    comisd xmm3, xmm2   ; tmp compare_with(c)
    jb ret_false        ; if tmp <= c => false
    
    movsd xmm3, xmm1
    addsd xmm3, xmm2
    comisd xmm3, xmm0
    jb ret_false
    
    movsd xmm3, xmm0
    addsd xmm3, xmm2
    comisd xmm3, xmm1
    jb ret_false

    jmp ret_true
    
    
global is_equilateral
is_equilateral:
    call init
    call are_all_positive
    cmp eax, 0
    je ret_false
    
    comisd xmm0, xmm1
    jne ret_false

    comisd xmm1, xmm2
    jne ret_false

    jmp ret_true
    
global is_isosceles
is_isosceles:
    call init
    
    call are_all_positive
    cmp eax, 0
    je ret_false
   
    call is_triangle_inequality_respected
    cmp eax, 0
    je ret_false
    
    comisd xmm0, xmm1
    je ret_true

    comisd xmm1, xmm2
    je ret_true

    comisd xmm0, xmm2
    je ret_true

    jmp ret_false

global is_scalene
is_scalene:
    call init
    
    call are_all_positive
    cmp eax, 0
    je ret_false
    
    call is_triangle_inequality_respected
    cmp eax, 0
    je ret_false
    
    comisd xmm0, xmm1
    je ret_false

    comisd xmm1, xmm2
    je ret_false

    comisd xmm0, xmm2
    je ret_false
    
    jmp ret_true

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif