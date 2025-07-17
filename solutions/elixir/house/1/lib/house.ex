defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """

  # I prefer to keep this in its natural order, 
  # but ideally it would start reversed
  @phrases [
    {"lay in", "the house that Jack built"},
    {"ate", "the malt"},
    {"killed", "the rat"},
    {"worried", "the cat"},
    {"tossed", "the dog"},
    {"milked", "the cow with the crumpled horn"},
    {"kissed", "the maiden all forlorn"},
    {"married", "the man all tattered and torn"},
    {"woke", "the priest all shaven and shorn"},
    {"kept", "the rooster that crowed in the morn"},
    {"belonged to", "the farmer sowing his corn"},
    {"", "the horse and the hound and the horn"},
  ]
  
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(x, x) do
    Enum.take(@phrases, x)
    |> Enum.reverse()
    |> Enum.reduce("", fn
      {_, object}, "" -> object
      {verb, object}, acc -> "#{acc} that #{verb} #{object}"
    end)
    |> (&"This is #{&1}.\n").()
  end
  def recite(start, stop) do
    Enum.map_join(start..stop, &recite(&1, &1))
  end
end
