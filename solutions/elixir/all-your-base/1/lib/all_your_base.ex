defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(_, _, out_base) when out_base < 2, 
  do: {:error, "output base must be >= 2"}
  def convert(_, in_base, _) when in_base < 2, 
  do: {:error, "input base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}
  def convert(digits, in_base, out_base) do
    if good_digits?(digits, in_base) do 
      digits 
      |> to_base_10(in_base) 
      |> convert_base(out_base)
      |> (&{:ok, &1}).()
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp good_digits?(digits, base) do
    Enum.all?(digits, &(&1 in 0..base-1))
  end

  defp to_base_10([], _), do: 0
  defp to_base_10([h | tl], base) do
    trunc(h * Integer.pow(base, length(tl))) + to_base_10(tl, base)
  end

  defp convert_base(_, _, digits \\ [])
  defp convert_base(0, _, []), do: [0]
  defp convert_base(0, _, digits), do: digits
  defp convert_base(n, base, digits) do
    convert_base(div(n, base), base, [rem(n, base) | digits])
  end
end
