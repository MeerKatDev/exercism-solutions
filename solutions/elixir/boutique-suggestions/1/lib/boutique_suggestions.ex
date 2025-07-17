defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, opts \\ [maximum_price: 100]) do
    mprice = opts[:maximum_price]
    for x <- tops, y <- bottoms,
        x[:base_color] != y[:base_color] and
        mprice != nil and
        (x[:price] + y[:price]) <= mprice do
        {x, y}
    end
  end
end
