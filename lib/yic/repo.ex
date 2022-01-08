defmodule Yic.Repo do
  use Ecto.Repo,
    otp_app: :yic,
    adapter: Ecto.Adapters.Postgres
end
