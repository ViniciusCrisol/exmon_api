defmodule ExMon.Trainer.Pokemon.Delete do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> verify_uuid_and_delete_trainer_pokemon()
  end

  defp verify_uuid_and_delete_trainer_pokemon(:error),
    do: {:error, :unauthorized, "Invalid ID format!"}

  defp verify_uuid_and_delete_trainer_pokemon({:ok, uuid}) do
    uuid
    |> fetch_trainer_pokemon()
    |> delete_trainer_pokemon()
  end

  defp delete_trainer_pokemon(nil), do: {:error, :not_found, "Pokemon not found!"}
  defp delete_trainer_pokemon(pokemon), do: Repo.delete(pokemon)

  defp fetch_trainer_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
