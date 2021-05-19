defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent

  def generate(fileName) do
    str =
      Agent.get_all()
      |> Map.values()
      |> Enum.map(&to_line(&1))
    File.write!(fileName, str)
  end

  def to_line(%Flightex.Bookings.Booking{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id,
        id: id
      }) do
    "#{user_id}, #{local_origin}, #{local_destination},#{complete_date.year}, #{complete_date.month},#{complete_date.day},#{complete_date.hour},#{complete_date.minute},#{complete_date.second}"
  end
end
