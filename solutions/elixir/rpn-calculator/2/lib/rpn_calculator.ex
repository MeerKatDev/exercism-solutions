defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue 
      _e in ArgumentError -> :error
      _e in RuntimeError ->  :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue e in ArgumentError -> 
      {:error, e.message}
    end
  end
end
