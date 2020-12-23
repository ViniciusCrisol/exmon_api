defmodule ExMonWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_mon

  alias ExMon.{Repo, Trainer}
  alias Ecto.UUID

  def subject_for_token(trainer, _claims) do
    sub = to_string(trainer.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExMon.fetch_trainer()
  end

  def authenticate(%{"id" => trainer_id, "password" => password}) do
    trainer_id
    |> UUID.cast()
    |> verify_uuid_and_authenticate_trainer(password)
  end

  defp verify_uuid_and_authenticate_trainer(:error, _password),
    do: {:error, :unauthorized, "Invalid ID format!"}

  defp verify_uuid_and_authenticate_trainer({:ok, trainer_id}, password) do
    case Repo.get(Trainer, trainer_id) do
      nil -> {:error, :not_found, "Trainer not found!"}
      trainer -> validate_password(trainer, password)
    end
  end

  defp validate_password(%Trainer{password_hash: hash} = trainer, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized, "Trainer unauthoeized!"}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claims} = encode_and_sign(trainer)
    {:ok, token}
  end
end
