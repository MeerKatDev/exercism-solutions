default rel

section .rodata
    prefix:        db "One for ", 0              ; Static string prefix
    suffix:        db ", one for me.", 0         ; Static string suffix
    default_name:  db "you", 0                   ; Fallback name if input is NULL

section .text
    global two_fer

; ------------------------------------------------------------------------------
; void two_fer(const char* name, char* buffer)
;
; Parameters:
;   RDI = name (can be NULL)
;   RSI = buffer (write result here)
;
; Writes: "One for <name>, one for me." into the buffer.
; ------------------------------------------------------------------------------

two_fer:
    ; Check if 'name' (RDI) is NULL
    test rdi, rdi         ; Sets zero flag if RDI == 0
    jnz .use_given_name   ; If not null, jump to use the given name

    ; If name == NULL, use "you"
    lea rdi, [rel default_name]   ; RDI = pointer to "you"

.use_given_name:
    ; Copy "One for " into buffer
    lea rcx, [rel prefix]         ; RCX = source = pointer to "One for "
    call copy_string              ; RSI = dest = buffer; advances RSI to end

    ; Copy name (RDI) into buffer
    mov rcx, rdi                  ; RCX = source = name string
    call copy_string              ; RSI moves forward again

    ; Copy ", one for me." into buffer
    lea rcx, [rel suffix]         ; RCX = source = suffix
    call copy_string              ; RSI advances again

    ; Null-terminate the final string
    mov byte [rsi], 0             ; RSI is now at the end → write null byte

    ret                           ; Done!

; ------------------------------------------------------------------------------
; copy_string:
;   Copies null-terminated string from RCX to RSI.
;   Advances RSI pointer to the end of copied string.
;   Assumes RSI and RCX are set before calling.
; ------------------------------------------------------------------------------

copy_string:
.copy:
    mov al, [rcx]         ; Load byte from source
    mov [rsi], al         ; Store byte into destination
    inc rcx               ; Move source pointer forward
    inc rsi               ; Move destination pointer forward
    test al, al           ; Check if byte was null terminator
    jnz .copy             ; If not null, keep copying

    dec rsi               ; Step back to overwrite null terminator in next copy
    ret                   ; Return with RSI adjusted
