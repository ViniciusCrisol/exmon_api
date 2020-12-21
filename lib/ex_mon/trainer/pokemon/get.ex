defmodule ExMon.Trainer.Pokemon.Get do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> verify_uuid_and_get_pokemon()
  end

  defp verify_uuid_and_get_pokemon(:error),
    do: {:error, :unauthorized, "Invalid ID format!"}

  defp verify_uuid_and_get_pokemon({:ok, uuid}) do
    uuid
    |> fetch_pokemon()
    |> get_pokemon()
    |> get_pokemon_trainer()
  end

  defp get_pokemon(nil), do: {:error, :not_found, "Pokemon not found!"}
  defp get_pokemon(pokemon), do: {:ok, pokemon}

  defp get_pokemon_trainer({:error, _status, _reason} = error), do: error
  defp get_pokemon_trainer({:ok, pokemon}), do: {:ok, Repo.preload(pokemon, :trainer)}

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
