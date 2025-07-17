defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """
  @numbers ["no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    numbers = 
      @numbers
      |> Enum.slice(start_bottle-take_down, take_down + 1) 
      |> Enum.reverse()
      
    Enum.reduce(1..take_down, {numbers, []}, 
      fn _, {[i, j | acc], text_acc} ->
      { [j | acc],  text_acc ++ [par(i, j)]}
    end)
    |> elem(1)
    |> Enum.join("\n")
    |> String.trim()
  end
  
  defp par(i, j) do
    """
    #{String.capitalize(i)} green bottle#{if i != "one", do: "s", else: "" } hanging on the wall,
    #{String.capitalize(i)} green bottle#{if i != "one", do: "s", else: "" } hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{j} green bottle#{if j != "one", do: "s", else: "" } hanging on the wall.
    """
  end
end
