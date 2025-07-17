defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) :: integer
  #recursion is king
  def maximum_value([], _), do: 0
  def maximum_value([%{weight: w} | tl], remd) when w > remd,
    do: maximum_value(tl, remd)
  def maximum_value([%{weight: w, value: v} | rest], remd) do
    max(maximum_value(rest, remd - w) + v, maximum_value(rest, remd))
  end
end
