defmodule KitchenCalculator do
  def get_volume({_, num}) do
    num
  end

  def to_milliliter({unit, num}) do
    {:milliliter, num * table(unit)}
  end

  defp table(unit) do
    case unit do
      :cup -> 240
      :fluid_ounce -> 30
      :teaspoon -> 5
      :tablespoon -> 15
      :milliliter -> 1
    end
  end

  def from_milliliter({:milliliter, num}, unit_to) do
    {unit_to, num / table(unit_to)}
  end

  def convert({unit_from, num}, unit_to) do
    {_, ml} = to_milliliter({unit_from, num})
    {unit_to, ml / table(unit_to)}
  end
end
