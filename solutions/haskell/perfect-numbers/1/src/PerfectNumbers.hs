module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n
  | n > 0 = Just $ doClassify (factors n) n
  | otherwise = Nothing

doClassify :: Int -> Int -> Classification
doClassify s n 
  | n == s = Perfect
  | s > n  = Abundant
  | s < n  = Deficient

factors :: Int -> Int
factors n = 
  foldr (\x acc -> if (rem n x == 0) then (x + acc) else acc) 0 [1..(n-1)]
