defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    task = Task.async(fn -> calculator.(input) end)
    %{input: input, pid: task.pid}
  end

  def await_reliability_check_result(%{input: input, pid: pid}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> :ok
      {:EXIT, ^pid, _}       -> :error
    after
      100 -> :timeout
    end
    |> (&Map.put(results, input, &1)).()
  end

  def reliability_check(calculator, inputs) do
    old_flag = Process.flag(:trap_exit, true)
    inputs
    |> Enum.map(&start_reliability_check(calculator, &1)) 
    |> Enum.reduce(%{}, &await_reliability_check_result(&1,&2))
    |> (fn results -> 
      Process.flag(:trap_exit, old_flag)
      results
    end).()
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, 100))
  end
end
