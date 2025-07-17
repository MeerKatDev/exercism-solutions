# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]

  defdelegate fetch(coin, key), to: Map
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> [] end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1)
  end

  def register(pid, register_to) do
    plot = %Plot{plot_id: generate_id(), registered_to: register_to}
    Agent.get_and_update(pid, &{plot, [plot | &1]})
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn li -> Enum.reject(li, &(&1[:plot_id] == plot_id)) end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn li -> Enum.find(li, &(&1[:plot_id] == plot_id)) end)
    |> case do
      nil -> {:not_found, "plot is unregistered"}
      plot_tuple -> plot_tuple
    end
  end

  defp generate_id() do
  :crypto.strong_rand_bytes(6)
  |> Base.url_encode64(padding: false)
  end
end
