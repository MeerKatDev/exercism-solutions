defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(str, size) when byte_size(str) >= size and size > 0 do
    rec(str, size)
  end
  def largest_product(_, _), do: raise ArgumentError

  # the idea is that it works like a stack:
  #  - the `else` branch accumulates the first cycles,
  #  - then the `if` continues in a window-like fashion
  defp rec(_, _, stack \\ [], mx \\ 0)
  defp rec(<<h::binary-size(1)>> <> tl, size, old_stack, mx) do
    hh = String.to_integer(h)
    if length(old_stack) == (size-1) do
      mxx = max(hh * Enum.product(old_stack), mx)
      rec(tl, size, [hh | Enum.drop(old_stack, -1)], mxx)
    else
      rec(tl, size, [hh | old_stack], mx)
    end
  end
  defp rec("", _, _, mx), do: mx
end
