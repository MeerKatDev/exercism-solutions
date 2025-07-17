defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    r = :math.sqrt(x*x + y*y)
    cond do
      r <= 1 -> 10
      r <= 5 -> 5
      r <= 10 -> 1
      true -> 0
    end
  end
end
