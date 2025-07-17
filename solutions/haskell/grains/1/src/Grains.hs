module Grains (square, total) where


square :: Integer -> Maybe Integer
square n
    | n > 0 && n < 65 = Just $ 2^(n-1) -- can optimize with modular exponentiation
    | otherwise       = Nothing

total :: Integer
total = pred $ 2 ^ 64

