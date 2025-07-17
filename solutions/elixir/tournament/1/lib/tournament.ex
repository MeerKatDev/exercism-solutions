defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  defmodule Position do
    defstruct played: 1, won: 0, drawn: 0, lost: 0
  end

  import Enum
  alias __MODULE__.Position

  @possible_values ["win", "loss", "draw"]

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    map(input, &String.split(&1, [";"]))
    |> reduce(%{}, fn
      [team1, team2, res], acc when res in ["win", "loss", "draw"] ->
        acc
        |> Map.update(team1, init_val(res), &update(&1, res))
        |> Map.update(team2, init_val(inv(res)), &update(&1, inv(res)))
      _, acc ->
        acc
    end)
    |> sort(&(pts(&1) >= pts(&2)))
    |> format_to_table
  end

  defp pts({_k, v}), do: v.won * 3 + v.drawn
  defp pts(v), do: pts({nil, v})

  defp format_to_table(map) do
    "Team                           | MP |  W |  D |  L |  P\n" <>
      map_join(map, "\n", fn {k, v} ->
        ~s(#{String.pad_trailing(k, 31)}|  #{v.played} |  #{v.won} |  #{v.drawn} |  #{v.lost} |  #{
          pts(v)
        })
      end)
  end

  defp inv("win"), do: "loss"
  defp inv("loss"), do: "win"
  defp inv("draw"), do: "draw"

  defp init_val("win"), do: %Position{won: 1}
  defp init_val("loss"), do: %Position{lost: 1}
  defp init_val("draw"), do: %Position{drawn: 1}
  defp update(current, "win"), do: increase_by_one(current, :played) |> increase_by_one(:won)
  defp update(current, "loss"), do: increase_by_one(current, :played) |> increase_by_one(:lost)
  defp update(current, "draw"), do: increase_by_one(current, :played) |> increase_by_one(:drawn)
  defp increase_by_one(map, key), do: Map.update!(map, key, &(&1 + 1))
end
