defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db, name, grade) do
    Map.merge(db, %{grade => [name]}, fn _k, v1, v2 -> v1 ++ v2 end)
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade) do
    db[grade] || []
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    Enum.sort(db, fn {k1, _v1}, {k2, _v2} ->
      k1 <= k2
    end)
    |> Enum.map(fn {k, v} -> {k, Enum.sort(v)} end)
  end
end
