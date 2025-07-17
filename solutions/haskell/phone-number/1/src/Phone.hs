module Phone (number) where

import Text.Read (readMaybe)
import Data.Maybe (catMaybes)

number :: String -> Maybe String
number xs = isCorrect $ concatMap show $ catMaybes $ map readInt xs

isCorrect :: String -> Maybe String
isCorrect ('1':xs) = checkSubCodes xs
isCorrect xs = checkSubCodes xs

checkSubCodes xs = 
  if length xs == 10 
  then 
    case xs of
      _:_:_:'0':_ -> Nothing
      _:_:_:'1':_ -> Nothing
      '0':_ -> Nothing
      '1':_ -> Nothing
      num -> Just num
  else 
    Nothing

readInt :: Char -> Maybe Int
readInt i = readMaybe [i] :: Maybe Int
