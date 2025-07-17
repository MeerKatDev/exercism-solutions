module SumOfMultiples (sumOfMultiples) where

import Data.List( nub )

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = 
  let 
    goodFactors = filter (\x -> x < limit) factors
    mapRange h = map (h*) (range limit h)
  in
    sum $ nub $ goodFactors >>= mapRange

range :: Integer -> Integer -> [Integer]
range _ 0 = [0]
range n h = [1..(div (n-1) h)]