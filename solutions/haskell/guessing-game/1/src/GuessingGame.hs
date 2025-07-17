module GuessingGame (reply) where

reply :: Int -> String
reply 42 = "Correct"
reply n 
  | abs (42 - n) == 1 = "So close"
  | n < 41 = "Too low"
  | n > 43 = "Too high"
