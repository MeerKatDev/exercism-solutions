defmodule LogLevel do

  def to_label(level, legacy?) do
    cond do
      legacy? and level in [0,5] -> :unknown
      level in 0..5 ->
        case level do
          0 -> :trace
          1 -> :debug
          2 -> :info
          3 -> :warning
          4 -> :error
          5 -> :fatal
        end
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      label in [:error, :fatal] -> :ops
      label == :unknown -> legacy? && :dev1 || :dev2
      true -> nil
    end
  end
end
