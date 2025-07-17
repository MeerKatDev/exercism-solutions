defmodule NameBadge do
  def print(id, name, department) do
    cond do
      id == nil and department == nil ->
        "#{name} - OWNER"
      id == nil ->
        "#{name} - #{String.upcase(department)}"
      department == nil ->
        "[#{id}] - #{name} - OWNER"
      true ->      
        "[#{id}] - #{name} - #{String.upcase(department)}"
    end
  end
end
