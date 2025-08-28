defmodule Shopflow.Repo do
  use Ecto.Repo,
    otp_app: :shopflow,
    adapter: Ecto.Adapters.Postgres
end
