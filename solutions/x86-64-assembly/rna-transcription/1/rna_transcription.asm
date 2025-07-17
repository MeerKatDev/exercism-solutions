section .text
global to_rna
to_rna:
    ; rdi = input (pointer to null-terminated string)
    ; rsi = output (caller must pass a buffer for the result)

    xor rax, rax        ; clear return value if needed
.loop:
    mov al, byte [rdi]  ; load character from input
    cmp al, 0
    je .out             ; end of string?

    cmp al, 'G'
    je .to_c
    cmp al, 'C'
    je .to_g
    cmp al, 'T'
    je .to_a
    cmp al, 'A'
    je .to_u
    jmp .invalid

.to_c:
    mov byte [rsi], 'C'
    jmp .next
.to_g:
    mov byte [rsi], 'G'
    jmp .next
.to_a:
    mov byte [rsi], 'A'
    jmp .next
.to_u:
    mov byte [rsi], 'U'
    jmp .next

.next:
    inc rdi             ; move to next input char
    inc rsi             ; move to next output char
    jmp .loop

.out:
    mov byte [rsi], 0   ; null-terminate output
    ret

.invalid:
    ; optional: return error (e.g., rax = -1)
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
