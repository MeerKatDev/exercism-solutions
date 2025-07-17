module Pangram (isPangram) where

import Data.List
import Data.Char ( isAscii, isLetter, toLower )

isPangram :: String -> Bool
isPangram text = 
  (length $ nub $ map toLower $ normalize text) == 26
  where 
    normalize str = filter (and . sequence [isLetter, isAscii]) str
