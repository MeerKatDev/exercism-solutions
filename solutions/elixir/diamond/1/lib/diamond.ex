defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    Enum.reduce(?A..letter, [], fn c, acc ->
        [pad(<<c::utf8>>, letter - c, letter - ?A) | acc]
    end)
    |> mirror_list
    |> Enum.join("\n")
    |> (&"#{&1}\n").()
  end

  defp pad("A", left, _) do
    "A"
    |> String.pad_leading(left + 1) 
    |> (&String.pad_trailing(&1, byte_size(&1) + left)).()
  end
  defp pad(str, left, right) do
    str
    |> String.pad_leading(left + 1) 
    |> String.pad_trailing(right)
    |> (&(&1 <> " " <> String.reverse(&1))).()
  end

  defp mirror_list(l), do: Enum.reverse(l) ++ Enum.drop(l, 1)
end
