defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """

  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, charlist()}
  def convert(input) when rem(length(input), 4) != 0, do: {:error, 'invalid line count'}
  def convert(input) when rem(byte_size(hd(input)), 3) != 0, 
  do: {:error, 'invalid column count'}

  def convert(input) when length(input) > 4 do
    Enum.chunk_every(input, 4)
    |> Enum.map_join(",", &translate/1)
    |> (&{:ok, &1}).()
  end

  def convert(input), do: {:ok, translate(input)}

  defp translate(input) do
    Enum.join(rec(input))
  end

  defp rec(_, acc \\ [])
  defp rec(["", "", "", ""], acc), do: acc
  defp rec([
    <<h1 :: binary-size(3)>> <> t1,
    <<h2 :: binary-size(3)>> <> t2,
    <<h3 :: binary-size(3)>> <> t3,
    <<h4 :: binary-size(3)>> <> t4 
    ], acc) do
    rec([t1, t2, t3, t4], acc ++ [pick_number([h1, h2, h3, h4])])
  end

  defp pick_number(lst) do
    case lst do
      [" _ ", "| |", "|_|", "   "] -> 0
      ["   ", "  |", "  |", "   "] -> 1
      [" _ ", " _|", "|_ ", "   "] -> 2
      [" _ ", " _|", " _|", "   "] -> 3
      ["   ", "|_|", "  |", "   "] -> 4
      [" _ ", "|_ ", " _|", "   "] -> 5
      [" _ ", "|_ ", "|_|", "   "] -> 6
      [" _ ", "  |", "  |", "   "] -> 7
      [" _ ", "|_|", "|_|", "   "] -> 8
      [" _ ", "|_|", " _|", "   "] -> 9
      _ -> '?'
    end
  end

end
