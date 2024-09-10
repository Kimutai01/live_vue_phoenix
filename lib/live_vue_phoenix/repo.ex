defmodule LiveVuePhoenix.Repo do
  use Ecto.Repo,
    otp_app: :live_vue_phoenix,
    adapter: Ecto.Adapters.Postgres
end
