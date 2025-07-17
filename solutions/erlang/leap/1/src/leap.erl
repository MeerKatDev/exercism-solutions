-module(leap).

-export([leap_year/1]).

-spec leap_year(integer()) -> boolean().
leap_year(Year) when is_integer(Year), Year rem 400 == 0 -> true;
leap_year(Year) when is_integer(Year), Year rem 100 /= 0, Year rem 4 == 0 -> true;
leap_year(_Year) -> false.
