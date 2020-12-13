defmodule ExMon.Trainer.Get do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> verify_uuid_and_get_trainer()
  end

  defp verify_uuid_and_get_trainer(:error), do: {:error, "Invalid ID format!"}

  defp verify_uuid_and_get_trainer({:ok, uuid}) do
    uuid
    |> fetch_trainer()
    |> get_trainer()
  end

  defp get_trainer(nil), do: {:error, "Trainer not found!"}
  defp get_trainer(trainer), do: {:ok, trainer}

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
