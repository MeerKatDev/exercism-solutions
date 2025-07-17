module CryptoSquare (encode) where

-- zipN would be useful here
import Data.Char (toLower, isAlphaNum)
import Data.List (transpose)
import Data.List.Split (chunksOf)

encode :: String -> String
encode xs = 
  unwords $ transpose chunks
  where
    list = normalize xs
    (row, col) = dimensions $ length list
    padded = padRight (row*col) list 
    chunks = chunksOf col padded

dimensions :: Int -> (Int, Int)
dimensions n =
  let c = ceiling . sqrt $ fromIntegral n
      r = ceiling (fromIntegral n / fromIntegral c :: Double)
  in (r, c)

normalize :: [Char] -> [Char]
normalize = filter isAlphaNum . map toLower

padRight :: Int -> [Char] -> [Char]
padRight n l = take n $ l ++ repeat ' '
    