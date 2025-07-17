module Pangram (isPangram) where

import Data.List
import Data.Char ( isAscii, isLetter, toLower )

isPangram :: String -> Bool
isPangram text = 
  (== 26) $ length $ nub $ map toLower $ normalize text
  where 
    normalize str = filter (and . sequence [isLetter, isAscii]) str
