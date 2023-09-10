defmodule B3.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: B3.Endpoint,
        options: Application.get_env(:b3, B3.Endpoint)
      )
    ]

    opts = [strategy: :one_for_one, name: B3.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
