defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1[:price]), &<=/2)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1[:price]))
  end

  def increase_quantity(item, count) do
    Map.update!(item, :quantity_by_size, &(Enum.into(&1, %{}, fn {k, v} ->
      {k, v + count}
    end)))
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_k, v}, acc -> 
      acc + v
    end)
  end
end
