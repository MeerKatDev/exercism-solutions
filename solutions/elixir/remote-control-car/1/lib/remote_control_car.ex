defmodule RemoteControlCar do
  @enforce_keys [:nickname]

  defstruct [
    :nickname,
    battery_percentage: 100, 
    distance_driven_in_meters: 0
  ]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %{ new() | nickname: nickname }
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: meters}) do
    "#{meters} meters" 
  end

  def display_distance(_) do
    raise FunctionClauseError
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty" 
  end

  def display_battery(%RemoteControlCar{battery_percentage: perc}) do
    "Battery at #{perc}%" 
  end

  def display_battery(_) do
    raise FunctionClauseError
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = m) do
    m
  end

  def drive(%RemoteControlCar{
      distance_driven_in_meters: meters, 
      battery_percentage: perc
    } = m) do
    %{ m | distance_driven_in_meters: (meters + 20), battery_percentage: (perc - 1) }
  end

  def drive(_) do
    raise FunctionClauseError
  end
end
