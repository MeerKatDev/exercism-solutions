module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, fromList, adjust)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show, Read)

initialMap = fromList [ (A, 0), (C, 0), (G, 0), (T, 0) ]

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs = 
  if isValid then Right $ rec xs initialMap else Left ""
  where 
    isValid = all (\x -> elem x "ACTG") xs

rec :: String -> (Map Nucleotide Int) -> (Map Nucleotide Int)
rec "" acc = acc
rec (x:xs) acc = rec xs (adjust (+1) (read [x]::Nucleotide) acc)
  
