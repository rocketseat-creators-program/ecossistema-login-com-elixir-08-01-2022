defmodule ExpertLoginWeb.Sessions.Auth do
  import Plug.Conn

  def init(p), do: p

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, _user} <- get_user(token) do
      conn
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!(%{error: "unauthenticated"}))
        |> halt()
    end
  end

  def get_user(token) do
    Phoenix.Token.verify(ExpertLoginWeb.Endpoint, "login_user_token", token, max_age: 86400)
  end
end
