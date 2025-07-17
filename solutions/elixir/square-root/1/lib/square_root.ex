defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    # brute force
    do_calculate(1, radicand)
  end

  defp do_calculate(test, goal) when test * test == goal, do: test
  defp do_calculate(test, goal), do: do_calculate(test + 1, goal)
end
