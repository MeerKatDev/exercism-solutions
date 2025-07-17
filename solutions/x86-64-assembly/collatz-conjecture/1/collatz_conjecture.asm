section .text
global steps
steps:
    test edi, edi       ; bitwise comparison 
    jle .ret_error      ; guard function
    mov ebx, edi        ; move pointer edi into ebx register (edi is now empty)
    xor cl, cl          ; clear counter site
.rec:
    cmp ebx, 1          ; compare ebx <> 0 => je, jne, jge, etc..
    jg .make_step        ; if greater than 1, make another step, otherwise
    xor rax, rax        ; clear return site
    mov al, cl          ; move counter value into return reg
    ret                 ; and return
.make_step:
    inc cl              ; increase counter
    xor edx, edx        ; clear edx (tmp site)
    mov edx, ebx        ; move value in a tmp var
    and edx, 1          ; get reminder of byte [edx] / 2
    cmp edx, 0
    je .is_even
.is_odd:
    lea ebx, [ebx + ebx*2 + 1]  ; ebx = ebx * 3 + 1
    jmp .rec
.is_even:
    sar ebx, 1          ; shift right by 1 == divide by 2
    jmp .rec

.ret_error:
    xor rax, rax        ; clear return site
    mov eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
