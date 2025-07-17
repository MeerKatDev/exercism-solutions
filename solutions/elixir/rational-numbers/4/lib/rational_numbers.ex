defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, a2}, {b1, b2}) do
    reduce {a1 * b2 + a2 * b1,  a2 * b2 }
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, a2}, {b1, b2}) do
    reduce { a1 * b2 - a2 * b1, a2 * b2 }
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, a2}, {b1, b2}) do
    reduce { a1 * b1 , a2 * b2 }
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({_, 0}, _), do: :nope
  def divide_by(_, {0, _}), do: :nope
  def divide_by({a1, a2}, {b1, b2})  do
    reduce {a1 * b2, b1 * a2}
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs({a, b}) do
    reduce {max(a, -a), max(b, -b)}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(r :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when  n >= 0 do
    reduce {Integer.pow(a, n), Integer.pow(b, n)}
  end
  def pow_rational({a, b}, m) when  m < 0 do
    reduce {Integer.pow(b, m), Integer.pow(a, m)}
  end
  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(n :: integer, r :: rational) :: float
  def pow_real(n, {a, b}) do
    :math.pow(n * 1.0, a/b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce({a, b} = x) do
    {a, b} = normalize(x)
    g = Integer.gcd(a, b)
    {a / g, b / g}
  end

  defp normalize({a, b}) when b < 0, do: {-a, -b}
  defp normalize(x), do: x
end
