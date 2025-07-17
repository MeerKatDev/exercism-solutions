defmodule Username do
  def sanitize(username) do
    Enum.flat_map(username, fn 
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      c when (c in ?a..?z or c == ?_) -> [c]
      _ -> []
    end)
  end
end
