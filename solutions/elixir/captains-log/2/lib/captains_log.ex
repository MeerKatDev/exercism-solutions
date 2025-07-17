defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    n = Enum.random(1000..9999)
    "NCC-#{n}"
  end

  def random_stardate() do
    41000.0 + (1.0 - :rand.uniform()) * 1000
  end

  def format_stardate(stardate) when is_float(stardate) do
    :io_lib.format("~.1f", [stardate]) |> to_string
  end

  def format_stardate(_), do: raise ArgumentError
end
