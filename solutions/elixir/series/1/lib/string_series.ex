defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size > byte_size(s) or size < 1, do: []
  def slices(s, size) do
    combinations = byte_size(s) - size
    rec(s, size, combinations+1, [])
  end

  defp rec(_, _, 0, acc), do: acc# Enum.reject(acc, &(&1==""))
  defp rec(string, size, n, acc) do
    rec(string, size, n-1, [String.slice(string, n-1..size+n-2) | acc])
  end
end
