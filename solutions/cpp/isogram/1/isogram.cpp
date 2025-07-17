#include "isogram.h"
#include <iostream>
#include <ctype.h>

namespace isogram {

  bool is_isogram(std::string str) {
    std::map<char, int> m {};
    for(char& c : str) {
      m[tolower(c)] += 1;
    }
    m.erase(' ');
    m.erase('-');
    for (auto const& it : m) {
      if(it.second > 1)
        return false;
    }
    return true;
  }
}  // namespace isogram
