defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    rank_range() |> Enum.to_list()
  end

  def files do
    file_range() |> Enum.map(&<<&1::utf8>>)
  end
end
