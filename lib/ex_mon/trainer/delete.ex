defmodule ExMon.Trainer.Delete do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> verify_uuid_and_delete_trainer()
  end

  defp verify_uuid_and_delete_trainer(:error), do: {:error, "Invalid ID format!"}

  defp verify_uuid_and_delete_trainer({:ok, uuid}) do
    uuid
    |> fetch_trainer()
    |> delete_tariner()
  end

  defp delete_tariner(nil), do: {:error, "Trainer not found!"}
  defp delete_tariner(trainer), do: Repo.delete(trainer)

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
