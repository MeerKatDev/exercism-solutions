defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings) do
    do_recite(strings, "", Enum.at(strings, 0))
  end

  defp do_recite([], acc, _), do: acc
  defp do_recite([x, y | z], acc, h) do
    IO.inspect({x, y})
    do_recite([y | z], "#{concat(acc)}For want of a #{x} the #{y} was lost.", h)
  end
  defp do_recite([_x | []], acc, h) do
    do_recite([], "#{concat(acc)}And all for the want of a #{h}.\n", nil)
  end

  defp concat(""), do: "" 
  defp concat(str), do: str <> "\n"
  
end
