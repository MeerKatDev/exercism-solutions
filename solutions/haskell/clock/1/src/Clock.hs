module Clock (addDelta, fromHourMin, toString) where

data Clock = Clock Int Int
  deriving Eq

fromHourMin :: Int -> Int -> Clock
fromHourMin = normalize

toString :: Clock -> String
toString (Clock hour min) = 
  toTimeStr hour ++ ":" ++ toTimeStr min

addDelta :: Int -> Int -> Clock -> Clock
addDelta hourAdd minsAdd (Clock hour min) = 
  normalize (hour + hourAdd) (min + minsAdd)

normalize :: Int -> Int -> Clock 
normalize hour min = 
  Clock (cycleT (hour + div min 60) 24) (cycleT min 60)

cycleT :: Int -> Int -> Int
cycleT num sys
  | num < 0 = cycleT (sys + rem num sys) sys
  | otherwise = rem num sys 

toTimeStr :: Int -> String
toTimeStr num
  | num < 10  = "0" ++ show num
  | otherwise = show num
