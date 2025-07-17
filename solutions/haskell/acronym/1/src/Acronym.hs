module Acronym (abbreviate) where

import Data.Char(isSpace,isUpper,toUpper)

abbreviate :: String -> String
abbreviate xs = rec (filter (`notElem` "',_") xs) ""

-- it's ugly because I can't use regex's :((
rec :: String -> String -> String
rec [] acc = acc
rec ('-':' ':text) acc = rec text acc
rec (' ':'-':text) acc = rec text acc
rec (x:y:z:text) acc
    | isUpper x = rec text (acc ++ [x])
    | (isSpace x) = rec (z:text) (acc ++ [toUpper y])
    | ((x == '-') && (y /= ' ')) = rec (z:text) (acc ++ [toUpper y])
    | otherwise = rec (y:z:text) acc
rec sth acc = acc

