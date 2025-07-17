defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({re, _}) do
    re
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, im}) do
    im
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul({are, aim}, {bre, bim}) do
    {are * bre - aim * bim, aim * bre + are * bim}
  end
  def mul(a, {bre, bim}), do: {a * bre, a * bim}
  def mul({are, aim}, b), do: {are * b, aim * b}
  def mul(a, b), do: {a * b, 0}

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add({are, aim}, {bre, bim}) do
    {are + bre, aim + bim}
  end
  def add({are, aim}, b), do: {are + b, aim}
  def add(a, {bre, bim}), do: {a + bre, bim}
  def add(a, b), do: {a + b, 0}

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub(a, {bre, bim}) do
    add(a, {-bre, -bim})
  end
  def sub(a, b), do: add(a, -b)

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div({are, aim}, {bre, bim}) do
    den = bre * bre + bim * bim
    {(are * bre + aim * bim)/den, (aim * bre - are * bim)/den}
  end
  def div({_, _} = a, b), do: __MODULE__.div(a, {b, 0})
  def div(a, {_, _} = b), do: __MODULE__.div({a, 0}, b)
  def div(a, b), do: {a + b, 0}

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({re, im}) do
    :math.sqrt(re * re + im * im)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({re, im}) do
    {re, -im}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({re, im}) do
    coeff = :math.exp(re)
    {coeff * :math.cos(im), coeff * :math.sin(im)} 
  end
end
