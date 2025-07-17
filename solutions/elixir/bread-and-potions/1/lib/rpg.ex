defmodule RPG do
  
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    @type item :: Character.t() | LoafOfBread.t() | ManaPotion.t() | Poison.t() | EmptyBottle.t()

    @spec eat(RPG.item, Character.t()) :: {RPG.item, Character.t()}
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    @spec eat(LoafOfBread.t(), Character.t()) :: {nil, Character.t()}
    def eat(%LoafOfBread{}, %Character{health: health} = char) do
      {nil, %Character{char | health: (health + 5)}}
    end
  end

  defimpl Edible, for: ManaPotion do
    @spec eat(ManaPotion.t(), Character.t()) :: {EmptyBottle.t(), Character.t()}
    def eat(%ManaPotion{strength: s}, %Character{mana: m} = char) do
      {%EmptyBottle{}, %Character{char | mana: m + s}}
    end
  end

  defimpl Edible, for: Poison do
    @spec eat(Poison.t(), Character.t()) :: {EmptyBottle.t(), Character.t()}
    def eat(%Poison{}, %Character{} = char) do
      {%EmptyBottle{}, %Character{char | health: 0}}
    end
  end
end
