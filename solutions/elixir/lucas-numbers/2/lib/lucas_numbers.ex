defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when is_integer(count) and (count > 0) do
    Stream.iterate({2, 1}, fn {a, b} -> {b, a + b} end) 
    |> Enum.take(count) 
    |> Enum.map(& elem(&1, 1))
    |> Enum.drop(-1)
    |> (&[2|&1]).()
  end

  def generate(_) do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
end
