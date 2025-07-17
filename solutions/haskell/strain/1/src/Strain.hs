module Strain (keep, discard) where

discard :: (a -> Bool) -> [a] -> [a]
discard p xs = recFilter (not . p) xs

keep :: (a -> Bool) -> [a] -> [a]
keep p xs = recFilter p xs

recFilter :: (a -> Bool) -> [a] -> [a]
recFilter _ [] = []
recFilter p (h:tl) = if (p h) 
  then h : recFilter p tl
  else recFilter p tl