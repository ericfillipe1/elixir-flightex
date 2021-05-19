defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  use Agent

  def start_link(initial_state \\ %{}) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking, booking.id))
    {:ok, booking.id}
  end

  def get_all(), do: Agent.get(__MODULE__, & &1)
  def get(uuid), do: Agent.get(__MODULE__, &get_booking(&1, uuid))

  defp get_booking(state, uuid) do
    case state
         |> Map.values()
         |> Enum.filter(&filter(&1, uuid))
         |> Enum.fetch(0) do
      :error -> {:error, "Booking not found"}
      s -> s
    end
  end

  defp filter(state, uuid) do
    state.id == uuid
  end

  defp update_state(state, %Booking{} = booking, uuid), do: Map.put(state, uuid, booking)
end
