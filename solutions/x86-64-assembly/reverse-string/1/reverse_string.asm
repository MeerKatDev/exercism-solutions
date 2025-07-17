section .text
global reverse
reverse:
    mov rsi, rdi ; start by copying the initial pointer into rsi
                 ; rdi - pointer to null-terminated string, contains first argument
    
find_end:
    mov al, byte [rdi] ; move value pointed by rdi into al register
    cmp al, 0          ; compare al <> 0 => je, jne, jge, etc..
    je found_end
    inc rdi
    jmp find_end
found_end:
    ; found the end, now rdi points at the null terminator.
    dec rdi ; let's decrease it so it starts at the end of the string, not at the null terminator.
reverse_loop:
    mov al, byte [rdi]  ; put last char into tmp position
    mov bl, byte [rsi]  ; put first char into tmp2 position
    ; can't store them directly from rsi to rdi
    mov byte [rdi], bl  ; put tmp char into first position
    mov byte [rsi], al  ; put tmp char into first position
    dec rdi
    inc rsi
    cmp rsi, rdi
    jge done
    jmp reverse_loop
done: 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
