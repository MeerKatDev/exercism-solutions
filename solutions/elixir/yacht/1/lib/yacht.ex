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
          [_, x, x, x, x] = l -> Enum.drop(l, 1)
          [x, x, x, x, _] = l -> Enum.drop(l, -1)
          _               -> [0]
        end
        |> Enum.sum()
      :little_straight -> 
        consecutive?(dice) && Enum.min(dice) == 1 && 30 || 0
      :big_straight ->
        consecutive?(dice) && Enum.min(dice) == 2 && 30 || 0
      :choice -> Enum.sum(dice)
      :yacht -> all_equals(dice) && Enum.sum(dice) * 2 || 0
    end
  end

  defp all_equals([h | tl]), do: Enum.all?(tl, &(&1 == h))

  defp consecutive?(dice) do
    [h | tl]= d = Enum.sort(dice)
    d == Enum.to_list(h..List.last(tl))
  end

  defp number(dice, n) do
    Enum.reduce(dice, 0, fn 
      ^n, acc -> acc + n
      _, acc -> acc
    end)
  end
end
