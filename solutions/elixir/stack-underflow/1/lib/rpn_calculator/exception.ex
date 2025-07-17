defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @msg "stack underflow occurred"

    defexception message: @msg

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}
        _ ->
          %StackUnderflowError{message: "#{@msg}, context: #{value}"}
      end
    end
  end

  def divide(nums) when length(nums) < 2 do
    raise StackUnderflowError, "when dividing"
  end
  def divide([0, _]), do: raise DivisionByZeroError
  def divide([a, b]), do: trunc(b/a)
end
