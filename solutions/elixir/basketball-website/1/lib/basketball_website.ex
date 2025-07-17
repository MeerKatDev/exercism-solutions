defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> Enum.reduce(:init, fn 
    key, :init -> data[key]
    key, acc -> acc[key]
    end)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
