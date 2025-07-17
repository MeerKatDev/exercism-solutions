defmodule BirdCount do
  def today([]), do: nil
  def today([h | _]) do
    h
  end

  def increment_day_count([]), do: [1]
  def increment_day_count([h | tl]) do
    [h + 1 | tl]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | tl]), do: true
  def has_day_without_birds?([h | tl]), do: has_day_without_birds?(tl)

  def total(_, acc \\ 0)   
  def total([], acc), do: acc
  def total([h | tl], acc), do: total(tl, acc + h)

  def busy_days(_, acc \\ 0)
  def busy_days([], acc), do: acc
  def busy_days([n | tl], acc) when n > 4, do: busy_days(tl, acc + 1)
  def busy_days([h | tl], acc), do: busy_days(tl, acc)
end
