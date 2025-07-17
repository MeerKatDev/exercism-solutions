defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, a2}, {b1, b2}) do
    {a1 * b2 + a2 * b1,  Kernel.abs(b1 * b2) }
    |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, a2}, {b1, b2}) do
    { a1 * b2 - a2 * b1, Kernel.abs(b1 * b2) }
    |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, a2}, {b1, b2}) do
    { a1 * b1 , a2 * b2 }
    |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({_, 0}, _), do: :nope
  def divide_by(_, {0, _}), do: :nope
  def divide_by({a1, a2}, {b1, b2})  do
    {a1 * b2, b1 * a2}
    |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs({a, b}) do
    {Kernel.abs(a), Kernel.abs(b)}
    |> reduce()
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(r :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when  n >= 0 do
    {:math.pow(a, n), :math.pow(b, n)}
    |> reduce()
  end
  def pow_rational({a, b}, m) when  m < 0 do
    {:math.pow(b, m), :math.pow(a, m)}
    |> reduce()
  end
  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(n :: integer, r :: rational) :: float
  def pow_real(n, {a, b}) do
    :math.pow(n, a/b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce({0, _}), do: {0, 1}
  def reduce({a, b}) do
    factor = Integer.gcd(trunc(a), trunc(b))
    {trunc(a / factor), trunc(b / factor)} 
    |> normalize
  end

  defp normalize({a, b}) when a < 0 and b < 0 do
    {Kernel.abs(a), Kernel.abs(b)}
  end
  defp normalize({a, b}) when a < 0 or b < 0 do
    {-Kernel.abs(a), Kernel.abs(b)}
  end
  defp normalize(x), do: x
end
