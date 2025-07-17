module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n = if n > 0 
  then Just $ rec n 0
  else Nothing

rec :: Integer -> Integer -> Integer
rec n steps
  | n == 1       = steps
  | mod n 2 == 0 = rec (div n 2) (steps + 1)
  | otherwise    = rec (3 * n + 1) (steps + 1)
