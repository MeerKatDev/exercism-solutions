defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A  -> 0b0001
      ?C  -> 0b0010
      ?G  -> 0b0100
      ?T  -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode([]), do: <<>>
  def encode([hd | tl]) do
    ehd = encode_nucleotide(hd)
    <<(<<ehd::4>>)::bitstring, encode(tl)::bitstring>>
  end

  def decode(""), do: ''
  def decode(<<value::4, rest::bitstring>>) do
    [decode_nucleotide(value) | decode(rest)]
  end
end
