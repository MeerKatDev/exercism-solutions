defmodule FoodChain do
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """

  @spider_action "that wriggled and jiggled and tickled inside her"
  @last_line  "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  @parts [
    %{
      animal: "fly", 
      action: "I don't know why she swallowed the fly. Perhaps she'll die."
    },
    %{ 
      animal: "spider", 
      action: "It wriggled and jiggled and tickled inside her."
    },
    %{
      animal: "bird", 
      action: "How absurd to swallow a bird!"
    },
    %{animal: "cat", 
      action: "Imagine that, to swallow a cat!"
    },
    %{animal: "dog", 
      action: "What a hog, to swallow a dog!"
    },
    %{animal: "goat", 
      action: "Just opened her throat and swallowed a goat!"
    },
    %{animal: "cow", 
      action: "I don't know how she swallowed a cow!"
    },
    %{animal: "horse", 
      action: "She's dead, of course!"
    }
  ]

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(n, n), do: recite(n)
  def recite(start, stop), do: Enum.map_join(start..stop, "\n", &recite/1)

  defp recite(n) when n in [1,8] do
    @parts
    |> Enum.at(n-1)
    |> head_recite
  end

  defp recite(n) do
    @parts
    |> Enum.at(n-1)
    |> head_recite
    |> (&"#{&1}#{rep_part(n)}#{@last_line}").()
  end

  defp head_recite(%{animal: animal, action: action}) do
    "I know an old lady who swallowed a #{animal}.\n#{action}\n"
  end

  defp rep_part(0), do: ""
  defp rep_part(n), do: Enum.map_join((n-1)..1, "\n", &swallowed/1) <> "\n"

  defp swallowed(i) do
    %{animal: an1} = Enum.at(@parts, i)
    %{animal: an2} = Enum.at(@parts, i - 1)
    an2 = (an2 == "spider") && "#{an2} #{@spider_action}" || an2
    "She swallowed the #{an1} to catch the #{an2}."
  end
end
