defmodule ProteinTranslation do


  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    String.split(rna, ~r/.{3}/, include_captures: true, trim: true)
    |> Stream.transform([], fn cod, acc ->
      case of_codon(cod) do
        {:error, "invalid codon"} -> {["invalid"], nil}
        {:ok, "STOP"} -> {:halt, []}
        {:ok, valid_aa} ->
          if "invalid" in acc, do: {:halt, []}, else: {[valid_aa], []}
      end
    end)
    |> Enum.to_list()
    |> (fn list ->
      if "invalid" in list, do: {:error, "invalid RNA"}, else: {:ok, list}
    end).()
    # |> Keyword.values()
    # |> case do
    #   list ->
    #     if Enum.any?(list, &(&1 == "invalid codon")) do
    #       {:error, "invalid RNA"}
    #     else
    #       {:ok, Enum.take_while(list, &(&1 != "STOP"))}
    #     end
    # end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    %{
      "AUG" =>	"Methionine",
      "UUU" =>  "Phenylalanine",
      "UUC" =>  "Phenylalanine",
      "UUA" =>  "Leucine",
      "UUG" =>	"Leucine",
      "UCU" =>	"Serine",
      "UCC" =>	"Serine",
      "UCA" =>	"Serine",
      "UCG" =>	"Serine",
      "UAU" =>	"Tyrosine",
      "UAC" =>	"Tyrosine",
      "UGU" =>	"Cysteine",
      "UGC" =>	"Cysteine",
      "UGG" =>	"Tryptophan",
      "UAA" =>	"STOP",
      "UAG" =>	"STOP",
      "UGA" =>	"STOP"
    }[codon]
    |> case do
      nil -> {:error, "invalid codon"}
      cod -> {:ok, cod}
    end
  end
end
