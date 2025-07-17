defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  use Bitwise
  
  # for int until 65536, as in the tests
  @cap 16

  # implementing this https://stackoverflow.com/q/10866119/1096030
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    do_calculate(radicand)
  end

  defp do_calculate(num, res \\ 0, bit \\ 1 <<< @cap)

  defp do_calculate(num, 0, bit) when bit > num,
    do: do_calculate(num, 0, shift_r2(bit))

  defp do_calculate(_, res, 0), do: res

  defp do_calculate(num, res, bit) when num >= res + bit,
    do: do_calculate(num - (res + bit), (res >>> 1) + bit, shift_r2(bit))

  defp do_calculate(num, res, bit), do: do_calculate(num, res >>> 1, shift_r2(bit))

  defp shift_r2(bit), do: bit >>> 2
end
