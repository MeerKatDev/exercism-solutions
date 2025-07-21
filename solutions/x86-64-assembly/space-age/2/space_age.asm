section .data
    seconds_in_year: dd 31557600.0
    planets: dd 0.2408467, 0.61519726, 1.0, 1.8808158, 11.862615, 29.447498, 84.016846, 164.79132

section .text
; rdi - planet index
; rsi - age in seconds
global age
age:
    cvtsi2ss xmm0, rsi                 ; xmm0 = convert input age in seconds to float
    movss xmm1, [rel seconds_in_year]  ; xmm1 = load seconds in Earth year
    lea rax, [rel planets]             ; load base address of planets in rax
    mulss xmm1, [rax + rdi * 4]        ; seconds_in_year *= planet coefficient 
    divss xmm0, xmm1                   ; age_in_planet_years = seconds / planet_seconds
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
