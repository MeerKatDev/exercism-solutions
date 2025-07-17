#include "darts.h"

#include <math.h>

uint8_t
score(coordinate_t landing_position) {
  float dist = sqrt(powf(landing_position.x, 2) + powf(landing_position.y, 2));
  if(dist <= 1)
    return 10;
  else if(dist <= 5)
    return 5;
  else if(dist <= 10)
    return 1;
  else
    return 0;
}
