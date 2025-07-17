module Bob (responseFor) where

import Data.Char ( toUpper, isLetter, isSpace )

responseFor :: String -> String
responseFor xs = 
  if allSpaces xs then "Fine. Be that way!"
  else if (isYelling xs) && (isQuestion xs) then "Calm down, I know what I'm doing!"
  else if isYelling xs then "Whoa, chill out!"
  else if isQuestion $ trim xs then "Sure."
  else "Whatever."

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
  
