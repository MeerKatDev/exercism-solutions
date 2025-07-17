module LuciansLusciousLasagna (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes) where

expectedMinutesInOven :: Integer
expectedMinutesInOven = 40

preparationTimeInMinutes :: Integer -> Integer
preparationTimeInMinutes n = n * 2

elapsedTimeInMinutes :: Integer -> Integer -> Integer
elapsedTimeInMinutes mins inOven = inOven + preparationTimeInMinutes mins
