module CryptoSquare (encode) where

-- zipN would be useful here
import Data.Char (toLower, isAlphaNum)
import Data.List (intercalate)

encode :: String -> String
encode xs = 
  intercalate " " $ map (\x -> (map (getAt x) chunks)) [0..(rowsNum-1)]
  where
    list = normalize xs
    rowsNum = getRectWidth list
    chunks = splitEvery rowsNum list

normalize :: [Char] -> [Char]
normalize xs = (filter isAlphaNum) $ map toLower xs

getRectWidth :: [Char] -> Int
getRectWidth xs = ceiling . sqrt . fromIntegral $ length xs

splitEvery _ [] = []
splitEvery n list = first : (splitEvery n rest)
  where
    (first,rest) = splitAt n list

padRight :: a -> Int -> [a] -> [a]
padRight c s l = take s (l ++ repeat c)

getAt :: Int -> [Char] -> Char
getAt _ [] = ' '
getAt y (x:xs) 
  | y <= 0 = x
  | otherwise = getAt (y-1) xs
    