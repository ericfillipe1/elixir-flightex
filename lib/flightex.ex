defmodule Flightex do
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent

  @spec start_agents :: any
  def start_agents() do
    BookingAgent.start_link(%{})
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdate, as: :call
end
