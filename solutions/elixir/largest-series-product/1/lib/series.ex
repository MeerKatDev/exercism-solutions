defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(str, size) when byte_size(str) >= size and size > 0 do
    # solution using strictly functions from the standard library.
    # traversing the string 6 times, not ideal.
    str
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(size, 1)
    |> Enum.filter(&(length(&1) == size))
    |> Enum.map(&Enum.product/1)
    |> Enum.max
  end
  def largest_product(str, size), do: raise ArgumentError
end
