defmodule ExpertLoginWeb.SessionController do
  use ExpertLoginWeb, :controller
  alias ExpertLogin.Users

  def sessions(conn, %{"user" => user}) do
    case Users.get_user(user["email"], user["password"]) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> json(%{message: "invalid user/password"})

      user ->
        token = Phoenix.Token.sign(ExpertLoginWeb.Endpoint, "login_user_token", user)

        conn
        |> put_status(:created)
        |> json(%{token: token})
    end
  end
end
