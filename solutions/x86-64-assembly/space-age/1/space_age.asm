section .data
    seconds_in_year: dd 31557600.0
    mercury: dd 0.2408467 
    venus: dd 0.61519726
    earth: dd 1.0
    mars: dd 1.8808158
    jupiter: dd 11.862615
    saturn: dd 29.447498
    uranus: dd 84.016846
    neptune: dd 164.79132

section .text
; rdi - planet index
; rsi - age in seconds
global age
age:
    cmp rdi, 0
    je .calc_mercury
    cmp rdi, 1
    je .calc_venus
    cmp rdi, 2
    je .calc_earth
    cmp rdi, 3
    je .calc_mars
    cmp rdi, 4
    je .calc_jupiter
    cmp rdi, 5
    je .calc_saturn
    cmp rdi, 6
    je .calc_uranus
    cmp rdi, 7
    je .calc_neptune

.calc_mercury:
    movss xmm1, [rel mercury]
    jmp .compute
.calc_venus:
    movss xmm1, [rel venus]
    jmp .compute
.calc_earth:
    movss xmm1, [rel earth]
    jmp .compute
.calc_mars:
    movss xmm1, [rel mars]
    jmp .compute
.calc_jupiter:
    movss xmm1, [rel jupiter]
    jmp .compute
.calc_saturn:
    movss xmm1, [rel saturn]
    jmp .compute
.calc_uranus:
    movss xmm1, [rel uranus]
    jmp .compute
.calc_neptune:
    movss xmm1, [rel neptune]
    jmp .compute

.compute:                              ; xmm1 = planet year length (in Earth years)
    mulss xmm1, [rel seconds_in_year]  ; planet_seconds = earth_years * seconds_in_year
    cvtsi2ss xmm0, rsi                 ; convert age in seconds to float
    divss xmm0, xmm1                   ; age_in_planet_years = seconds / planet_seconds
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
