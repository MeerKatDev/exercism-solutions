defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    time = Integer.mod(hour * 60 + minute, 24 * 60)
    %__MODULE__{
      hour: div(time, 60),
      minute: rem(time, 60)
    }
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
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
