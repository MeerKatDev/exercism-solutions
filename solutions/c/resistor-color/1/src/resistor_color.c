#include "resistor_color.h"
#include <stdio.h>
#include <stdlib.h>

#define ENUM_SIZE 10

uint8_t color_code(resistor_band_t color) {
  return color;
}

const resistor_band_t* colors() {
	resistor_band_t* arr = malloc(ENUM_SIZE * sizeof(resistor_band_t));

	for(uint8_t i = 0; i < ENUM_SIZE; i++) {
		arr[i]=i;
	}

  return arr;
}
