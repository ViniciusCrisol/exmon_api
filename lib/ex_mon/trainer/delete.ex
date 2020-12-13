defmodule ExMon.Trainer.Delete do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> verify_uuid()
  end

  defp verify_uuid(:error), do: {:error, "Invalid ID format!"}

  defp verify_uuid({:ok, uuid}) do
    uuid
    |> fetch_trainer()
    |> verify_tariner_exists()
  end

  defp verify_tariner_exists(nil), do: {:error, "Trainer not found!"}
  defp verify_tariner_exists(trainer), do: Repo.delete(trainer)

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
