defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: non_neg_integer()) :: non_neg_integer()
  def egg_count(0), do: 0
  def egg_count(number) do
    bin_digits = floor(:math.log2(number)) + 1
    zeroes = List.duplicate(0, bin_digits)
    search_number(zeroes, number)
  end

  defp search_number([], 1, acc), do: Enum.sum(acc) + 1
  defp search_number([], 0, acc), do: Enum.sum(acc)
  
  defp search_number([0 | bin], number, acc \\ []) do
    new_num = Integer.undigits([1 | bin], 2)
    if new_num <= number do
      search_number(bin, number - new_num, [1 | acc])
    else
      search_number(bin, number, [0 | acc])
    end
  end
end
