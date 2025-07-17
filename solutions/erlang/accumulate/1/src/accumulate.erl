-module(accumulate).

-export([accumulate/2]).

% for an empty map it returns an empty string? weird.
accumulate(_Fn, []) -> [];
accumulate(Fn, Ls) ->
  lists:map(Fn, Ls).
