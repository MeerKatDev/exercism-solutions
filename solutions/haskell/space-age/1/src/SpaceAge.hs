{-# LANGUAGE NumericUnderscores #-}

module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

yearInSecondsOnEarth = 31_557_600

ageOn :: Planet -> Float -> Float
ageOn planet seconds = 
  case planet of 
    Mercury -> convertToPlanetAge 0.2408467
    Venus -> convertToPlanetAge 0.61519726
    Earth -> convertToPlanetAge 1
    Mars -> convertToPlanetAge 1.8808158
    Jupiter -> convertToPlanetAge 11.862615
    Saturn -> convertToPlanetAge 29.447498
    Uranus -> convertToPlanetAge 84.016846
    Neptune -> convertToPlanetAge 164.79132
  where 
    convertToPlanetAge coeff = seconds /( yearInSecondsOnEarth * coeff )