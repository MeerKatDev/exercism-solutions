defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}
  @alphabet_len 26
  @integers ?0..?9

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if Integer.gcd(a, @alphabet_len) != 1 do
      {:error, "a and m must be coprime."}
    else
      message
      |> String.downcase
      |> (&Regex.replace(~r/[^a-z\d]/, &1, "")).()
      |> loop_str(&encode_char/3, a, b)
      |> (&Regex.scan(~r/.{1,5}/, &1)).()
      |> Enum.join(" ")
      |> (&{:ok, &1}).()
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    if Integer.gcd(a, @alphabet_len) != 1 do
      {:error, "a and m must be coprime."}
    else 
      encrypted
      |> String.replace("\s", "")
      |> loop_str(&decode_char/3, a, b)
      |> (&{:ok, &1}).()
    end
  end

  defp loop_str(str, fun, a, b) do
    for <<x::utf8 <- str>>, into: "", do: fun.(x, a, b)
  end

  defp encode_char(c, _, _) when c in @integers, do: <<c::utf8>>
  defp encode_char(c, a, b), do: num_to_char(a*(c - ?a) + b)

  defp decode_char(c, _, _) when c in @integers, do: <<c::utf8>>
  defp decode_char(c, a, b), do: num_to_char(((c - ?a) - b) * mmi(a))

  defp num_to_char(n) do
    <<?a + Integer.mod(n, @alphabet_len)::utf8>>
  end

  defp mmi(a) do
    {1, n, _} = Integer.extended_gcd(a, @alphabet_len)
    n < 0 && (@alphabet_len + n) || n
  end
end
