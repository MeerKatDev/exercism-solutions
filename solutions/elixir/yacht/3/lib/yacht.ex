defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    case category do
      :ones -> number(dice, 1)
      :twos -> number(dice, 2)
      :threes -> number(dice, 3)
      :fours -> number(dice, 4)
      :fives -> number(dice, 5)
      :sixes -> number(dice, 6)
      :full_house -> 
        case Enum.sort(dice) do
          [x, x, y, y, y] when x != y -> Enum.sum(dice)
          [x, x, x, y, y] when x != y -> Enum.sum(dice)
          _               -> 0
        end
      :four_of_a_kind -> 
        case Enum.sort(dice) do
          [_, x, x, x, x] -> x * 4
          [x, x, x, x, _] -> x * 4
          _               -> 0
        end
      :little_straight -> 
        consecutive?(dice) && Enum.min(dice) == 1 && 30 || 0
      :big_straight ->
        consecutive?(dice) && Enum.min(dice) == 2 && 30 || 0
      :choice -> Enum.sum(dice)
      :yacht -> all_equals(dice) && Enum.sum(dice) * 2 || 0
    end
  end

  defp all_equals([h | tl]), do: Enum.all?(tl, &(&1 == h))

  defp consecutive?(dice), do: Enum.sort(dice) |> do_consecutive?
  
  defp do_consecutive?([]), do: true
  defp do_consecutive?([_]), do: true
  defp do_consecutive?([x, y | rest]) when y - x == 1, do: do_consecutive?([y | rest])
  defp do_consecutive?([_ | _]), do: false

  defp number(dice, n) do
    Enum.reduce(dice, 0, fn 
      ^n, acc -> acc + n
      _, acc -> acc
    end)
  end
end
