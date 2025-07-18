#ifndef RESISTOR_COLOR_H
#define RESISTOR_COLOR_H

#include <stdint.h>

typedef enum {
   BLACK = 0, BROWN, RED, ORANGE, YELLOW,
   GREEN, BLUE, VIOLET, GREY, WHITE
} resistor_band_t;

uint8_t color_code(resistor_band_t color);

const resistor_band_t* colors();

#endif
