defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf) do
    with {:ok, cpf} <- build_cpf(cpf) do
      {
        :ok,
        %__MODULE__{
          name: name,
          email: email,
          cpf: cpf,
          id: UUID.uuid4()
        }
      }
    else
      err -> err
    end
  end

  def build_cpf(cpf) when is_bitstring(cpf) do
    {:ok, cpf}
  end

  def build_cpf(_cpf) do
    {:error, "Cpf must be a String"}
  end
end
