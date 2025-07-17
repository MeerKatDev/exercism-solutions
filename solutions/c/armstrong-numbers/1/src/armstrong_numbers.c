#include "armstrong_numbers.h"

#include <math.h>
#include <stdlib.h>
#include <stdio.h>


bool
is_armstrong_number(int candidate) {
  if(candidate == 0)
    return true;
  else {
    int len = floor(log10(abs(candidate))) + 1;
    char digits[len];
    sprintf(digits, "%d", candidate);
    int dsum = 0;
    for(int i = 0; i < len; i++) {
      dsum += pow(digits[i] - '0', len);
    }
    return candidate == dsum;
  }
}
