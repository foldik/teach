defmodule Teach.Repo do
  use Ecto.Repo,
    otp_app: :teach,
    adapter: Ecto.Adapters.Postgres
end
