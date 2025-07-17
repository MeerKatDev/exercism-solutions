defmodule TopSecret do
  @spec to_ast(String.t()) :: Macro.t()
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  @spec decode_secret_message_part(Macro.t(), [String.t()]) :: {Macro.t(), [String.t()]}
  def decode_secret_message_part({op, _, [{fn_name, _, args}, _]} = ast, acc) 
    when op in [:def, :defp] do
    case {args, fn_name} do
      {_, :when} -> 
        {fn_name, _, args} = hd(args)
        {ast, [name(fn_name, length(args) - 1) | acc]}
      {x, _} when x in [nil, []] -> {ast, ["" | acc]} 
      {sth, _} -> {ast, [name(fn_name, length(args) - 1) | acc]}
    end
  end
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
