module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA xs = 
  case (filter (\x -> not $ elem x "CGTA") xs) of
    "" -> Right $ map convert xs
    xf -> Left $ head xf

convert :: Char -> Char
convert a = 
  case a of 
    'G' -> 'C'
    'C' -> 'G'
    'T' -> 'A'
    'A' -> 'U'
