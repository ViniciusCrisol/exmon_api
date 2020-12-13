defmodule ExMon.Trainer.Update do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    uuid
    |> UUID.cast()
    |> verify_uuid_and_update_trainer(params)
  end

  defp verify_uuid_and_update_trainer(:error, _params), do: {:error, "Invalid ID format!"}

  defp verify_uuid_and_update_trainer({:ok, uuid}, params) do
    uuid
    |> fetch_trainer()
    |> update_trainer(params)
  end

  defp update_trainer(nil, _params), do: {:error, "Trainer not found!"}

  defp update_trainer(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
