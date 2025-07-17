defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    colors
    |> Enum.map(fn
      :black  -> 0
      :brown  -> 1
      :red    -> 2
      :orange -> 3
      :yellow -> 4
      :green  -> 5
      :blue   -> 6
      :violet -> 7
      :grey   -> 8
      :white  -> 9
    end)
    |> pick_unit
    |> (&{Integer.undigits(elem(&1, 0)), elem(&1, 1)}).()
  end

  defp pick_unit([x, y, zeroes]) when zeroes > 3  do
    {[x,y] ++ (for _ <- 0..(zeroes-4), do: 0), :kiloohms}
  end
  defp pick_unit([x, y, 0]), do: {[x,y], :ohms}
  defp pick_unit([x, y, 1]), do: {[x,y,0], :ohms}
  defp pick_unit([x, 0, 2]), do: {[x], :kiloohms}
  defp pick_unit([x, y, 3]), do: {[x,y], :kiloohms}
end
