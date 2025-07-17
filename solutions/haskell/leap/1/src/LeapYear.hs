module LeapYear (isLeapYear) where

-- followed this code review to improve this
-- https://codereview.stackexchange.com/q/125749/214558
type Year = Integer

isLeapYear :: Year -> Bool
isLeapYear y = divisibleBy 400 || (divisibleBy 4 && not (divisibleBy 100))
  where 
    divisibleBy x = mod y x == 0
