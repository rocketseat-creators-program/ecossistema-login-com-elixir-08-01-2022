defmodule ExpertLogin.Repo do
  use Ecto.Repo,
    otp_app: :expertLogin,
    adapter: Ecto.Adapters.MyXQL
end
