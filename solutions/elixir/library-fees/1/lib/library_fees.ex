defmodule LibraryFees do
  alias NaiveDateTime, as: NDT

  @type ndt() :: NaiveDateTime.t()
  
  @spec datetime_from_string(binary) :: ndt()
  def datetime_from_string(string), do: NDT.from_iso8601!(string)

  @spec before_noon?(ndt()) :: boolean
  def before_noon?(%NaiveDateTime{hour: hour}), do: (hour < 12)

  @spec return_date(ndt()) :: ndt()
  def return_date(checkout_datetime) do
    checkout_datetime
    |> NDT.to_date()
    |> Date.add(before_noon?(checkout_datetime) && 28 || 29)
  end

  @spec days_late(Date.t(), ndt()) :: integer()
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NDT.to_date()
    |> Date.diff(planned_return_date)
    |> Kernel.max(0)
  end

  @spec monday?(ndt()) :: boolean
  def monday?(datetime) do
    datetime
    |> NDT.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  @spec calculate_late_fee(String.t(), String.t(), number) :: number
  def calculate_late_fee(checkout, return, rate) do
    returned_dt = datetime_from_string(return)
    checkout_dt = datetime_from_string(checkout)

    checkout_dt
    |> return_date()
    |> days_late(returned_dt)
    |> (&( &1 * rate)).()
    |> discount(returned_dt)
  end

  defp discount(fee, returned_dt) do
    fee - (monday?(returned_dt) && round(fee * 0.5) || 0)
  end
  
end
