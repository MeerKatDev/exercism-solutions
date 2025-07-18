section .text
global square_root
; for (bit = 1 << 30; bit > 0; bit >>= 1) {
;    temp = result | bit;
;    if (temp * temp <= n) {
;        result = temp;
;    }
; }
square_root:
    xor rax, rax
    mov rsi, 1
    shl rsi, 29
.loop:
    mov rdx, rax    ;    temp (rdx) = result (rax)
    or rdx, rsi     ;    temp (rdx) |= bit (rsi);
    mov rcx, rdx    ;    tmp2 (rcx) = temp (rdx)
    imul rcx, rdx   ;    tmp2 (rcx) *= temp (rdx)
    cmp rcx, rdi    ;    if (tmp2 <= n)
    jg .skip_assign
    mov rax, rdx    ; result = temp

.skip_assign:
    shr rsi, 1      ; bit >>= 1
    cmp rsi, 0
    jne .loop
    ret

    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
