defmodule TopSecret do
  @spec to_ast(String.t()) :: Macro.t()
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  @spec decode_secret_message_part(Macro.t(), [String.t()]) :: {Macro.t(), [String.t()]}

  def decode_secret_message_part({_, _, [{:when, _, [{fn_name, _, args}|_]}, _]} = ast, acc), do: {ast, [name(fn_name, length(args) - 1) | acc]}
  def decode_secret_message_part({op, _, [{fn_name, _, args}, _]} = ast, acc) 
    when op in [:def, :defp] and args in [nil, []], do: {ast, ["" | acc]} 
  def decode_secret_message_part({op, _, [{fn_name, _, args}, _]} = ast, acc) 
    when op in [:def, :defp], do: {ast, [name(fn_name, length(args) - 1) | acc]}
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    string
    |> to_ast
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse
    |> Enum.join
  end

  defp name(atom, upp), do: "#{String.slice("#{atom}", 0..upp)}"
end
