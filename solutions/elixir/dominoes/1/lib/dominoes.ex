defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([h | tl]), do: do_chain?(h, tl)

  defp do_chain?({a, b}, []), do: a == b
  defp do_chain?(chain, dominoes) do 
    # search for a candidate in every iteration
    # without the present element.
    Enum.any?(dominoes, &do_chain?(chain, &1, List.delete(dominoes, &1)))
  end
  defp do_chain?({l, x}, {x, r}, dominoes), do: do_chain?({l, r}, dominoes)
  defp do_chain?({l, x}, {r, x}, dominoes), do: do_chain?({l, r}, dominoes)
  # if we cannot continue the chaining, no sense in continuing
  defp do_chain?(_, _, _), do: false
end
