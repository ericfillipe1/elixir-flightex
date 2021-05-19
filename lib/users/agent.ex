defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(initial_state \\ %{}) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user, user.id))
    {:ok, user.id}
  end

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case state
         |> Map.values()
         |> Enum.filter(&filter(&1, cpf))
         |> Enum.fetch(0) do
      :error -> {:error, "User not found"}
      s -> s
    end
  end

  defp filter(state, cpf) do
    state.cpf == cpf
  end

  defp update_state(state, %User{} = user, uuid), do: Map.put(state, uuid, user)
end
