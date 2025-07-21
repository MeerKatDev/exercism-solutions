section .text
global steps
steps:
    test edi, edi       ; bitwise comparison 
    jle .ret_error      ; guard function
    mov edx, edi        ; move pointer edi into edx register (edi is now empty)
    xor cl, cl          ; clear counter site
.rec:
    cmp edx, 1          ; compare edx <> 0 => je, jne, jge, etc..
    jg .make_step        ; if greater than 1, make another step, otherwise
    xor rax, rax        ; clear return site
    mov al, cl          ; move counter value into return reg
    ret                 ; and return
.make_step:
    inc cl              ; increase counter
    test edx, 1         ; checks the LSB if it's zero or one (even or odd)
    je .is_even
.is_odd:
    lea edx, [edx + edx*2 + 1]  ; edx = edx * 3 + 1
    jmp .rec
.is_even:
    sar edx, 1          ; shift right by 1 == divide by 2
    jmp .rec

.ret_error:
    xor rax, rax        ; clear return site
    mov eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
