module SumOfMultiples (sumOfMultiples) where

import Data.List( nub )

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = 
  sum $ nub $ rec (filter (\x -> x < limit) factors) limit []

rec:: [Integer] -> Integer -> [Integer] -> [Integer]
rec [] _ acc = 
  acc
rec (0:tl) n acc =
  rec tl n (acc ++ [0])
rec (h:tl) n acc =
  rec tl n (acc ++ [(x * h) | x <- [1..(div (n-1) h)]])
