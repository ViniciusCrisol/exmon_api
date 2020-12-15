defmodule ExMonWeb.FallbackController do
  use ExMonWeb, :controller

  def call(conn, {:error, status, result}) do
    conn
    |> put_status(status)
    |> put_view(ExMonWeb.ErrorView)
    |> render("error.json", result: result)
  end
end
