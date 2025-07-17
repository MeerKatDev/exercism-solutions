defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([hd | tl]) do
    tl
  end

  def first([hd | tl]) do
    hd
  end

  def count(list) do
    length(list)
  end

  def exciting_list?(list) do
    "Elixir" in list
  end
end
