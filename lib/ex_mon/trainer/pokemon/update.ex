defmodule ExMon.Trainer.Pokemon.Update do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    uuid
    |> UUID.cast()
    |> verify_uuid_and_update_pokemon(params)
  end

  defp verify_uuid_and_update_pokemon(:error, _params),
    do: {:error, :unauthorized, "Invalid ID format!"}

  defp verify_uuid_and_update_pokemon({:ok, uuid}, params) do
    uuid
    |> fetch_pokemon()
    |> update_pokemon(params)
  end

  defp update_pokemon(nil, _params), do: {:error, :not_found, "Pokemon not found!"}

  defp update_pokemon(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
