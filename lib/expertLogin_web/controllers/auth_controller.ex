defmodule ExpertLoginWeb.AuthController do
  use ExpertLoginWeb, :controller

  plug Ueberauth

  def call(conn, params) do
    IO.inspect(conn)
    IO.inspect(params)
    render(conn, "index.html")
  end
end
