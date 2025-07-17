defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}
  
  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_currency, locale, []), do: header(locale)
  def format_entries(currency, locale, entries) do
      header(locale) <> process(currency, locale, entries) <> "\n"
  end

  defp padded_str_num(num) do
    num 
    |> to_string() 
    |> String.pad_leading(2, "0")
  end

  defp make_date(%{date: %{year: yy, month: mm, day: dd}}) do
    {to_string(yy), padded_str_num(mm), padded_str_num(dd)}
  end
  
  defp date(:en_US, {year, month, day}), do: month <> "/" <> day <> "/" <> year <> " "
  defp date(_, {year, month, day}), do: day <> "-" <> month <> "-" <> year <> " "

  defp decimal(entry) do
    entry.amount_in_cents 
    |> abs 
    |> rem(100) 
    |> to_string() 
    |> String.pad_leading(2, "0")
  end

  defp fmt_amount(entry, currency, locale) do
    number = process_number(entry, locale)
    case {entry.amount_in_cents >= 0, locale} do
      {true, :en_US} -> "  #{symbol(currency)}#{number} "
      {true, _} ->  " #{symbol(currency)} #{number} "
      {false, :en_US} -> " (#{symbol(currency)}#{number})"
      {false, _} -> " #{symbol(currency)} -#{number} "
    end
    |> String.pad_leading(14, " ")
  end

  defp fmt_entry(currency, locale, entry) do
    date = date(locale, make_date(entry))
    amount = fmt_amount(entry, currency, locale)
    description = fmt_description(entry.description)

    Enum.join([date, "|", description, " |", amount])
  end

  defp symbol(:eur), do: "€"
  defp symbol(_), do: "$"

  defp fmt_description(text) when byte_size(text) > 26, do: " " <> String.slice(text, 0, 22) <> "..."
  defp fmt_description(text), do: " " <> String.pad_trailing(text, 25, " ")
  
  defp header(:en_US), do: "Date       | Description               | Change       \n"
  defp header(_), do: "Datum      | Omschrijving              | Verandering  \n"

  ## This might be a bit of a stretch but it was fun to make :D
  defp entries_order(%{date: %{day: a_day}}, %{date: %{day: b_day}}) when a_day < b_day, do: true
  defp entries_order(%{date: %{day: a_day}}, %{date: %{day: b_day}}) when a_day > b_day, do: false
  defp entries_order(%{description: a_desc}, %{description: b_desc}) when a_desc < b_desc, do: true
  defp entries_order(%{description: a_desc}, %{description: b_desc}) when a_desc > b_desc, do: false
  defp entries_order(%{amount_in_cents: a_cents}, %{amount_in_cents: b_cents}), do: a_cents <= b_cents

  defp process(currency, locale, entries) do
    Enum.sort(entries, &entries_order/2)
    |> Enum.map(fn entry -> fmt_entry(currency, locale, entry) end)
    |> Enum.join("\n")
  end
  
  defp num_separator(:en_US), do: {",", "."}
  defp num_separator(_), do: {".", ","}
  defp dollars(entry), do: abs(div(entry.amount_in_cents, 100))

  defp process_number(entry, locale) do
    {sep1, sep2} = num_separator(locale)
    
    whole =
      if dollars(entry) < 1000 do
         to_string(dollars(entry))
      else
        thousands = to_string(div(dollars(entry), 1000))
        remainder = to_string(rem(dollars(entry), 1000))
        thousands <> sep1 <> remainder
      end

    whole <> sep2 <> decimal(entry)
  end
end
