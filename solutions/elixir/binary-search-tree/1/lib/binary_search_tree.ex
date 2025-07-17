defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    new_node = %{data: data, left: nil, right: nil}
    if tree.data < data do
      Map.update!(tree, :right, fn
        nil -> new_node
        %{} = node -> insert(node, data)
      end)
    else
      Map.update!(tree, :left, fn
        nil -> new_node
        %{} = node -> insert(node, data)
      end)
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    rec(tree, [])
    |> Enum.sort() # can do without, ideally 
  end

  defp rec(nil, acc), do: acc
  defp rec(%{data: data, right: r, left: nil}, acc), do: rec(r, [data | acc])
  defp rec(%{data: data, right: nil, left: l}, acc), do: rec(l, [data | acc])
  defp rec(%{data: data, right: nil, left: nil}, acc), do: rec(nil, [data | acc])
  defp rec(%{data: data, right: r, left: l}, acc) do
    rec(l, [data]) ++ rec(r, acc)
  end
end
