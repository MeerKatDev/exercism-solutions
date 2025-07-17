module Pangram (isPangram) where

import Data.List
import Data.Char ( isAscii, isLetter, toLower )

isPangram :: String -> Bool
isPangram = (== 26) . length . nub . map toLower . normalize 
  where 
    normalize = filter $ and . sequence [isLetter, isAscii]
