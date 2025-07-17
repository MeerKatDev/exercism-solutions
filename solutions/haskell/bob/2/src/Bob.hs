module Bob (responseFor) where

import Data.Char ( toUpper, isLetter, isSpace )

responseFor :: String -> String
responseFor xs
  | allSpaces xs = "Fine. Be that way!"
  | (isYelling xs) && (isQuestion xs) = "Calm down, I know what I'm doing!"
  | isYelling xs = "Whoa, chill out!"
  | isQuestion $ trim xs = "Sure."
  | otherwise = "Whatever."

isQuestion :: String -> Bool
isQuestion str = (last str) == '?'

normalize :: String -> String
normalize str = filter isLetter str    

allSpaces :: String -> Bool
allSpaces str = all isSpace str

isYelling :: String -> Bool
isYelling str = (normalize str /= "") && (map toUpper str) == str

-- from https://stackoverflow.com/a/6270337
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace
  
