defmodule RobotSimulator do
  @moduledoc false

  @cc_directions [:north, :east, :south, :west]

  defguardp correct_dir(dir) when dir in @cc_directions
  defguardp correct_pos(a, b) when is_integer(a) and is_integer(b)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`

  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, {a, b} = pos) 
    when correct_dir(direction) and correct_pos(a, b) do
    %{dir: direction, pos: pos}
  end
  def create(direction, _) when correct_dir(direction), do: {:error, "invalid position"}
  def create(_, _), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> do_simulate(robot)
  end

  defp do_simulate(["R" | tl], %{dir: dir} = acc) do
    do_simulate(tl, %{acc | dir: change(+1, dir)})
  end

  defp do_simulate(["L" | tl], %{dir: dir} = acc) do
    do_simulate(tl, %{acc | dir: change(-1, dir)})
  end

  defp do_simulate(["A" | tl], acc) do
    Map.update!(acc, :pos, fn {x, y} ->
      case acc.dir do
        :north -> {x, y + 1}
        :east -> {x + 1, y}
        :south -> {x, y - 1}
        :west -> {x - 1, y}
      end
    end)
    |> (&do_simulate(tl, &1)).()
  end

  defp do_simulate([], acc), do: acc

  defp do_simulate(_, _) do
    {:error, "invalid instruction"}
  end

  defp change(c, dir) do
    new_idx = Enum.find_index(@cc_directions, &(&1 == dir)) + c
    Enum.at(@cc_directions, rem(new_idx, length(@cc_directions)))
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{dir: dir}), do: dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{pos: pos}), do: pos
end
