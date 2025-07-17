#include "isogram.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

bool
is_isogram(const char phrase[]) {
  if(phrase == NULL)
    return false;

  int len = strlen(phrase);
  int j;
  char c, d;
  for(int i=0; i<len; i++) {
    c = phrase[i];
    for(j=i+1; j<len; j++) {
      d = phrase[j];
      if(abs(c-d)%32==0 && c > 64 && d > 64) {
        return false;
      }
    }
  }
  return true;
}
