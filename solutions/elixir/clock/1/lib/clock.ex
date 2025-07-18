defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    %Clock{hour: rem(hour + div(minute, 60), 24), minute: rem(minute, 60)}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    %Clock{hour: rem(hour + div(add_minute, 60), 24), minute: minute + rem(add_minute, 60)}
  end

  defimpl String.Chars, for: Clock do
    def to_string(clock) do
      case {clock.hour, clock.minute} do
        {h, m} when h < 10 and m < 10 -> "0#{h}:0#{m}"
        {h, m} when h < 10 -> "0#{h}:#{m}"
        {h, m} when m < 10 -> "#{h}:0#{m}"
        {h, m} -> "#{h}:#{m}"
      end
    end
  end
end
