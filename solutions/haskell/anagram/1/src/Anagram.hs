module Anagram (anagramsFor) where

import Data.List
import Data.Char(toLower)

anagramsFor :: String -> [String] -> [String]
anagramsFor xs xss =
  filter isAnagram xss
  where 
    norm ts = sort $ map toLower ts
    isAnagram ys = (norm ys) == normed && (map toLower ys) /= lowered
    normed = norm xs
    lowered = (map toLower xs) 
