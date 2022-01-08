defmodule ExpertLoginWeb.AuthController do
  use ExpertLoginWeb, :controller

  plug Ueberauth

  # alias Ueberauth.Strategy.Helpers
  alias ExpertLoginWeb.UserFromAuth

   def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
   end

  @spec callback(Plug.Conn.t(), any) :: Plug.Conn.t()
  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do

    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{asigns: %{ueberauth_auth: auth}} = conn, _params) do

    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:curent_user, user)
        |> configure_session(renew: true)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
